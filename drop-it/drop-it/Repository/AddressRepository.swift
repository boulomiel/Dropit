//
//  AddressRepository.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//

import Foundation
import CoreData

struct AddressRepository{
    
    var context : NSManagedObjectContext
    
    init(_ context : NSManagedObjectContext){
        self.context =  context
    }
}

extension AddressRepository : RepositoryDelegate {
    
    func create<T>(_ obj: T) where T : DropCodable {
        guard let address = obj as? Address else{
            fatalError("UserRepository", file: "impossible to create a user")
        }
        do {
            let addressDb = AddressDb(context: context)
            addressDb.country =  address.country
            addressDb.city =  address.city
            addressDb.streetAddress =  address.streetAddress
            try context.save()
            print("Save Address", "address \(address.streetAddress) saved")
        }catch{
            print("Save Address", error)
        }
    }
    
    func update<T>(where: NSPredicate, _ obj: T) where T : DropCodable {
        guard let addressObj = obj as? Address else{
            fatalError("UserRepository", file: "impossible to create a user")
        }
        let request =  AddressDb.fetchRequest()
        do{
            if let address = try context.fetch(request).first{
                address.city = addressObj.city
                address.streetAddress =  addressObj.streetAddress
                address.country = addressObj.country
                try context.save()
            }else{
                create(obj)
            }
        }catch{
            print("UpdateAddress", error)
        }
    }
    
    func updateWithUser(user : User){
        let request =  AddressDb.fetchRequest()
        do{
            if let address = try context.fetch(request).first{
                let userDb =  UserDb(context: context)
                userDb.address = address
                userDb.fullName = user.fullName
                let phoneNumberDb =  PhoneNumberDb(context: context)
                phoneNumberDb.number =  user.phoneNumber.number
                phoneNumberDb.countryCode = Int32(user.phoneNumber.countryCode)
                phoneNumberDb.ofUser =  userDb
                address.ofUser =  userDb
                try context.save()
            }
        }catch{
            print("UpdateAddress", error)
        }
    }

    func removeAll(){
        let request =  AddressDb.fetchRequest()
        do{
            let addresses = try context.fetch(request)
            addresses.forEach { address in
                context.delete(address)
            }
            try context.save()
        }catch{
            print("All users removed")
        }
    }
    
    func fetch(for user : User) -> Address?{
        let request = AddressDb.fetchRequest()
        do{
            if let addressDb =  try context.fetch(request).first(where: {
                $0.ofUser != nil && $0.ofUser!.fullName == user.fullName
            }){
                return Address(streetAddress: addressDb.streetAddress ?? "", city: addressDb
                                .city ?? "", country: addressDb.country ?? "")
            }
        }catch{
           print("fetchAddress", error)
            return nil
        }
        return nil
    }
    
    func fetch<T>(where predicate : NSPredicate) -> T? where T : DropCodable {
        do{
            let request =  AddressDb.fetchRequest()
            let addresses = try context.fetch(request) as NSArray
            if let addressPredicated =  addresses.filtered(using: predicate).first as? AddressDb{
                return Address(streetAddress: addressPredicated.streetAddress ?? "", city: addressPredicated.city ?? "", country: addressPredicated.country ?? "") as? T
            }else{
                print("fetch address", "couldnt cast from predicate")
            }
        }catch{
            print("update", error)
            return nil
        }
        return nil
    }
    
    func fetchAll<T>() -> [T]? where T : DropCodable {
        do{
            let request =  AddressDb.fetchRequest()
            let addresses = try context.fetch(request)
            return addresses.compactMap { addressDb in
                Address(streetAddress: addressDb.streetAddress ?? "", city: addressDb.city ?? "", country: addressDb.country ?? "") as? T
            }
        }catch{
            print("update", error)
            return nil
        }
    }
}
