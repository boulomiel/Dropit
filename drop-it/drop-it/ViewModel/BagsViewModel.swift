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
    var bags : Observable<[String?]>  = Observable(value: [])
    
    init(_ apiClient : API){
        self.apiClient = apiClient
    }
    
    func addBag(
        _ bagId : String?,
        _ completion: @escaping ([String?])->Void
    ){
        bags.listener = completion
        bags.value?.append(bagId)
    }
}
