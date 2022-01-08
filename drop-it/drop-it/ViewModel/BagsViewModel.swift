//
//  BagsViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class BagsViewModel {
    var userCurrentBags = ["Zara", "Nike", "Amazon"]
    var bags : Observable<[String]>  = Observable(value: [])
    
    lazy var bagsRepository : BagsRepository = {
        let dropitRepository =  DropItRepository()
        return dropitRepository.bagsRepository
    }()
    func start(
        _ completion: @escaping ([String?])->Void
    ){
        clearBags()
        bags.listener = completion
    }
    
    func addBag(
        _ bagId : String
    ){
        bags.value?.append(bagId)
        bagsRepository.create(bagId)
    }
    
    func clearAllBagsFromDb(){
        bagsRepository.removeAll()
        clearBags()
    }
    
    private func clearBags(){
        bags.value  = []
    }
}
