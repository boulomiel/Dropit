//
//  Address.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

struct Address : DropCodable {
    var id : String {
        return UUID().uuidString
    }
    var streetAddress : String
    var city : String
    var country : String
}
