//
//  UserRepository.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//

import Foundation
import CoreData

struct UserRepository{
    var context : NSManagedObjectContext
    init(_ context : NSManagedObjectContext){
        self.context =  context
    }
}

extension UserRepository : RepositoryDelegate{
    func create<T>(_ obj: T) where T : DropCodable {
        guard let user = obj as? User else{
            fatalError("UserRepository", file: "impossible to create a user")
        }
        removeAll()
        do {
           let userDb = UserDb(context: context)
            userDb.id =  user.id
            userDb.fullName  = user.fullName
            let phoneNumber =  PhoneNumberDb(context: context)
            phoneNumber.countryCode =  Int32(user.phoneNumber.countryCode)
            phoneNumber.number = user.phoneNumber.number
            userDb.phoneNumber = phoneNumber
            try context.save()
            print("User \(user.fullName) saved")
        }catch{
            print("CreateUser", error)
        }
    }
    
    func update<T>(where predicate: NSPredicate, _ obj: T) where T : DropCodable {
        guard let user = obj as? User else{
            fatalError("UserRepository", file: "impossible to update a user")
        }
        
        do{
            let request =  NSFetchRequest<UserDb>(entityName: String(describing: UserDb.self))
            let users = try context.fetch(request) as NSArray
            if let userPredicated =  users.filtered(using: predicate).first as? UserDb{
                userPredicated.fullName = user.fullName
                let phoneNumberDb =  PhoneNumberDb(context: context)
                phoneNumberDb.number = user.phoneNumber.number
                phoneNumberDb.countryCode =  Int32(user.phoneNumber.countryCode)
                userPredicated.phoneNumber =  phoneNumberDb
                userPredicated.id  = user.id
                try context.save()
            }else{
                create(obj)
            }
        }catch{
            print("update", error)
        }
        
    }
    
    func removeAll(){
        let request =  UserDb.fetchRequest()
        do{
            let users = try context.fetch(request)
            users.forEach { user in
                context.delete(user)
            }
            try context.save()
        }catch{
            print("All users removed")
        }
        
    }

    func fetch<T>(where predicate: NSPredicate) -> T? where T : DropCodable {
        do{
            let request =  UserDb.fetchRequest()
            let users = try context.fetch(request) as NSArray
            if let userPredicated =  users.filtered(using: predicate).first as? UserDb{
                if let predicatedNumber =  userPredicated.phoneNumber{
                    let phoneNumber =  PhoneNumber(countryCode: Int(predicatedNumber.countryCode), number: predicatedNumber.number ?? "00-00-00-00-00")
                    let user = User(fullName: userPredicated.fullName ?? "Pikachu White", phoneNumber: phoneNumber)
                    return user as? T
                }else{
                    return nil
                }
            }else{
                print("update user", "couldnt cast from predicate")
            }
        }catch{
            print("update", error)
            return nil
        }
        return nil
    }
    
    func fetchAll<T>() -> [T] where T : DropCodable {
        do{
            let users = try context.fetch(UserDb.fetchRequest())
            let dropUsers: [T] = users.compactMap { userDb in
                if let userDbPhoneNumber =  userDb.phoneNumber{
                    let phoneNumber =  PhoneNumber(countryCode: Int(userDbPhoneNumber.countryCode ), number: userDbPhoneNumber.number ?? "" )
                    return  User(fullName: userDb.fullName ?? "Walter White", phoneNumber: phoneNumber) as? T
                }
                return  nil
            }
            return dropUsers.compactMap{$0}
        }catch{
            print("update", error)
            return []
        }
    }
}
