//
//  DropViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class DropViewModel {

    var userObserver : Observable<User>?
    var addressObserver : Observable<Address>?
    var bagsObserver : Observable<[String]>?
    var successObserver : Observable<Bool>?
    
    var apiClient : API
    
    init(_ apiClient : API){
        self.apiClient = apiClient
    }
    
    func getUser(){
        apiClient.start(User.self, request: RequestType.getContactDetails.request) {[weak self] result in
            switch result{
            case .success(let user):
                self?.userObserver?.value = user
            case .failure(let error):
                print("getUser", error)
            }
        }
    }
    
    func updateUser(){
        apiClient.start(User.self, request: RequestType.getContactDetails.request,completion: nil)
    }
    
    func getAddress(){
        apiClient.start(Address.self, request: RequestType.getContactDetails.request) {[weak self] result in
            switch result{
            case .success(let user):
                self?.addressObserver?.value = user
            case .failure(let error):
                print("getUser", error)
            }
        }
    }
    
    func updateAddress(){
        apiClient.start(User.self, request: RequestType.getContactDetails.request, completion: nil)
    }
    
    func dropBags(){
        
    }
    
}
