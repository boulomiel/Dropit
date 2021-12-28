//
//  API.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class API{
    
    static let shared = API()
    
    enum URlSessionError : Error {
        case httpError(Int), networkError(Error) ,decode
    }
    
    func start<T : Decodable>(_ type : T.Type,request : URLRequest ,completion : ((Result<T?, URlSessionError>) -> Void)? ){
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            if let httpResponse = urlResponse as? HTTPURLResponse {
                if !(200..<300).contains(httpResponse.statusCode){
                    completion?(.failure(.httpError(httpResponse.statusCode)))
                }
            }
            
            if let error = error {
                completion?(.failure(.networkError(error)))
            }
            if let data = data {
                if data.isEmpty{
                    completion?(.success(nil))
                }else{
                    do{
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion?(.success(result))
                    }catch{
                        completion?(.failure(.decode))
                    }
                }
            }
        }
        .resume()
    }
}
