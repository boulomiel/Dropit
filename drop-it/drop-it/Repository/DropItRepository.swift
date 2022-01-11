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
        let jsonURL =  Bundle.main.path(forResource: "fallback", ofType:  "json")!
        let content =  try! String(contentsOfFile: jsonURL).data(using: .utf8)!
        let datasource = try! JSONDecoder().decode(Dropper.self, from: content)
        return datasource
    }
    
    func removeAll(){
        userRepository.removeAll()
        addressRepository.removeAll()
        bagsRepository.removeAll()
    }
        
}
