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
}
