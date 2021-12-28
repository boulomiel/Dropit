//
//  Dropper.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

struct Dropper : DropCodable{
    
    let address: Address
    //cannot be read => key is 'contac Details'
   // let contacDetails: User
    let bags: [String]
}
