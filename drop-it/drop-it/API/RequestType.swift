//
//  RequestType.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

enum RequestType{
    
    case getContactDetails, updateContactDetails(User), getShippingAddress, updateShippingAddress(Address), dropBags([String])
        
    private var url : URL {
        switch self {
        case .getContactDetails , .updateContactDetails:
            return getURL(with: "user/contact")
        case .getShippingAddress, .updateShippingAddress:
            return getURL(with: "user/address")
        case .dropBags:
            return getURL(with: "drop")
        }
    }
    
    private var header : [String: String]{
        return ["Content-Type" : "application/json"]
    }
    
    private var body : Any?{
        switch self {
        case .getContactDetails, .getShippingAddress:
            return nil
        case .updateContactDetails(let user):
            return user.toDict()
        case .updateShippingAddress(let address):
            return address.toDict()
        case .dropBags(let bags):
            return bags
        }
    }
    
    private var httpMethod : URLRequest.HTTPMethod{
        switch self {
        case .getContactDetails:
            return .GET
        case .updateContactDetails:
            return .POST
        case .getShippingAddress:
             return .GET
        case .updateShippingAddress:
            return .POST
        case .dropBags:
            return .POST
        }
    }
    
    private func getURL(with endPoint : String) -> URL{
        let urlString =  "\(Constants.baseURL)\(endPoint)".replacingOccurrences(of: " ", with: "")
        return URL(string: urlString)!
    }
    
    var request : URLRequest {
        return URLRequest.create(url: url, method: httpMethod, headers: header, body: body)
    }
    
    var repository : RepositoryDelegate {
        let repository =  DropItRepository()
            switch self {
            case .getContactDetails:
                return repository.userRepository
            case .updateContactDetails:
                return repository.userRepository
            case .getShippingAddress:
                return repository.addressRepository
            case .updateShippingAddress:
                return repository.addressRepository
            case .dropBags:
                return repository.bagsRepository
            }
    }
}
