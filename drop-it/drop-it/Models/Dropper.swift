//
//  Dropper.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

struct Dropper : DropCodable{
    let address: Address
    let contactDetails: User
    let bags: [String]
    
    private enum CodingKeys : String, CodingKey {
        case contactDetails = "contact Details"
        case address = "address"
        case bags = "bags"
    }

}
