//
//  BagsRepository.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//

import Foundation
import CoreData

struct BagsRepository{
    var context : NSManagedObjectContext
    
    init(_ context : NSManagedObjectContext){
        self.context =  context
    }
}

extension BagsRepository : RepositoryDelegate  {
    func create<T>(_ obj: T) where T : DropCodable {}
    
    func update<T>(where: NSPredicate, _ obj: T) where T : DropCodable {}
    
    func remove<T>(_ obj: T) where T : DropCodable {}
    
    func fetchAll<T>() -> [T]? where T : DropCodable {nil}

    func create(_ obj: String) {
        let bagsDB =  BagDb(context: context)
        bagsDB.name = obj
        do{
           try  context.save()
        }catch{
            print("Create bag \(obj)", error)
        }
    }

    func remove(_ obj: String) {
        let bag =  BagDb(context: context)
        bag.name  = obj
        context.delete(bag)
        do{
           try  context.save()
        }catch{
            print("remove bag \(obj)", error)
        }
    }
    
    func removeAll(){
        let request = BagDb.fetchRequest()
        do{
            let bags =  try context.fetch(request)
            bags.forEach {
                context.delete($0)
            }
            try context.save()
        }catch{
            print("removeAll Bags", error)
        }
    }
    
    func fetch<T>(where: NSPredicate) -> T? where T : DropCodable {
        return nil
    }
    
    func fetchAll() -> [String] {
        let request = BagDb.fetchRequest()
        do{
            let bags =  try context.fetch(request)
            return bags.compactMap {
                $0.name
            }
        }catch{
            print("Fecth Bags", error)
            return []
        }
    }
    
}
