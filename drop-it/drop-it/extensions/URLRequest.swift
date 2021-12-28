//
//  URLRequest.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

extension URLRequest{
    
    enum HTTPMethod : String , CaseIterable {
        case GET, PUT, POST, DELETE, PUSH
    }
    
    static func create(url : URL, method : HTTPMethod, headers : [String:String],  body : Any? = nil) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        if let body = body {
            do{
                let data =  try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
                request.httpBody = data
            }catch{
                print("URLRequest", "create \(error.localizedDescription)")
            }
        }
        return request
    }
}
