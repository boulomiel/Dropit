//
//  BagsViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class BagsViewModel : RepositoryAccessor {
    
    var userCurrentBags = ["Zara", "Nike", "Amazon"]
    var bags : Observable<[String]>  = Observable(value: [])
    
    func start(
        _ completion: @escaping ([String?])->Void
    ){
        bags.value  = []
        bags.listener = completion
    }
    
    func addBag(
        _ bagId : String
    ){
        bags.value?.append(bagId)
        createBag(bag: Bag(name: bagId))
    }
    
    func clearAllBagsFromDb(){
        removeBags()
        bags.value  = []
    }

}
