//
//  ContactViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class ContactViewModel{
    
    var apiClient : API
    var data : Observable<User> = Observable(value: nil)
    var isUserUpdated : Observable<Bool> = Observable(value: false)
    
    init(_ apiClient : API){
        self.apiClient =  apiClient
    }
    
    func start(
        _ completionUser : @escaping((User?)->Void),
        _ completionUserUpdate : @escaping(Bool?) -> Void
    ){
        self.data.bind(completionUser)
        self.isUserUpdated.bind(completionUserUpdate)
        API.shared.start(User.self, request: RequestType.getContactDetails.request) {[weak self] result in
            switch result{
            case .success(let user):
                self?.data.value = user
            case .failure(let error):
                print("ContactViewModel", error)
            }
        }
    }
    
    func update(user : User){
        API.shared.start(User.self, request: RequestType.updateContactDetails(user).request){[weak self] result in
            switch result{
            case .success(_):
                self?.data.value = user
                self?.isUserUpdated.value = true
            case .failure(let error):
                print("ContactViewModel", error)
            }
        }
    }
}
