//
//  Bag.swift
//  drop-it
//
//  Created by Ruben Mimoun on 09/01/2022.
//

import Foundation

struct Bag : DropCodable{
    var id : String {
        return UUID().uuidString
    }
    var name : String
}
