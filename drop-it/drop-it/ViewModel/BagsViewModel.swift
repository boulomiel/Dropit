//
//  BagsViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class BagsViewModel {
    var apiClient : API
    var userCurrentBags = ["Zara", "Nike", "Amazon"]
    var bags : Observable<[String]>  = Observable(value: [])
    
    init(_ apiClient : API){
        self.apiClient = apiClient
    }
    
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
    }
    
    private func clearBags(){
        bags.value  = []
    }
}
