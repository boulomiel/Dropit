//
//  ContactViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class ContactViewModel{
    
    lazy var userRepository : UserRepository = {
       let dataRepository =  DropItRepository()
        return dataRepository.userRepository
    }()
    
    var data : Observable<User> = Observable(value: nil)
    var isUserUpdated : Observable<Bool> = Observable(value: false)
    var updateOperation : NetworkOperation<User>?

    func bind(
        _ completionUser : @escaping((User?)->Void),
        _ completionUserUpdate : @escaping((Bool?) -> Void)
    ){
        if let user : User = userRepository.fetchAll()?.first{
            self.data.value =  user
        }
        self.data.bind(completionUser)
        self.isUserUpdated.bind(completionUserUpdate)
    }
    
    func update(user : User){
        updateOperation = NetworkOperation(data: User.self, requestType: .updateContactDetails(user),completionBlock: {[weak self] in
            self?.updateRepository(user: user)
    
        })
        updateOperation?.start()
    }
    
    func disableUpdate(){
        isUserUpdated.value = false
    }
    
    private func updateRepository(user : User){
        DispatchQueue.main.async {[weak self] in
            self?.userRepository.removeAll()
            self?.userRepository.create(user)
            self?.data.value = user
            self?.isUserUpdated.value = true
        }
    }
}
