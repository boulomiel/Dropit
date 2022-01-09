//
//  User.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

struct User : DropCodable{
    var id  : String{
       return  UUID().uuidString
    }
    var fullName : String
    var phoneNumber : PhoneNumber
}

struct PhoneNumber : DropCodable{
    var countryCode : Int
    var number : String
}
