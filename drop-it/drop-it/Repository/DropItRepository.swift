//
//  DropItRepository.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//

import Foundation
import CoreData

struct DropItRepository  {
    
    private static var container : NSPersistentContainer  = {
        let container =  NSPersistentContainer(name: "DropIt")
        container.loadPersistentStores { store, error in
            if let error = error {
                fatalError("DropItRepository \(error)")
            }
        }
        return container
    }()

    lazy var context : NSManagedObjectContext = {
        return  Self.container.viewContext
    }()
    
    var userRepository : UserRepository!
    var addressRepository : AddressRepository!
    var bagsRepository : BagsRepository!
        
    init(){
        userRepository =  UserRepository(context)
        addressRepository =  AddressRepository(context)
        bagsRepository = BagsRepository(context)
    }
    
    func getJsonLocalData() -> Dropper{
        let jsonURL =  Bundle.main.path(forResource: "mock", ofType:  "json")!
        let content =  try! String(contentsOfFile: jsonURL).data(using: .utf8)!
        let datasource = try! JSONDecoder().decode(Dropper.self, from: content)
        return datasource
    }
    
    func getBags() -> [String]{
        let bags : [Bag]  = bagsRepository.fetchAll()
        let compacted =  bags.compactMap{$0.name}
        return compacted
    }
    
    func getAllData() -> [[Any]]{
        var data = [[Any]]()
        if let contactData : User = userRepository.fetchAll().last{
            data.append(contactData.toArr())
        }
        
        if let addressData : Address = addressRepository.fetchAll().first{
            data.append(addressData.toArr())
        }
        data.append(getBags())
        return data
    }
    
    func removeAll(){
        userRepository.removeAll()
        addressRepository.removeAll()
        bagsRepository.removeAll()
    }
        
}
