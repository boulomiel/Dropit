//
//  Dropper.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

struct Dropper : DropCodable{
    
    let address: Address
    let contacDetails: User
    let bags: [String]
}
