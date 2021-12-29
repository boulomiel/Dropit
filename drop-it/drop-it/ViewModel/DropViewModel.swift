//
//  DropViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class DropViewModel {
    
    private lazy var contactViewModel = ContactViewModel(apiClient)
    private lazy var addressViewModel =  AddressViewModel(apiClient)
    private lazy var bagsViewModel = BagsViewModel(apiClient)
    private lazy var reviewViewModel = ReviewViewModel(apiClient)
    private var apiClient : API
    
    init(_ apiClient : API){
        self.apiClient = apiClient
    }
    
    func getUser(
        _ completionUser : @escaping((User?)->Void),
        _ completionUserUpdate : @escaping(Bool?) -> Void
    ){
        contactViewModel.start(completionUser, completionUserUpdate)
    }
    
    func updateUser(user : User){
        contactViewModel.update(user: user)
    }
    
    func disableUpdate(){
        contactViewModel.isUserUpdated.value = false
    }
    
    func getAddress(
        _ completionAddress : @escaping((Address?)->Void),
        _ completionAddressUpdated : @escaping(Bool?) -> Void
    ){
        addressViewModel.start(completionAddress, completionAddressUpdated)
    }
    
    func updateAddress(address : Address){
        addressViewModel.update(address)
    }
    
    func startBagsUpdate(
        _ completion: @escaping ([String?])->Void
    ){
        bagsViewModel.start(completion)
    }
    
    func addBag(
        bagId : String
    ){
        bagsViewModel.addBag(bagId)
    }
    
    func startTableReview(
        _ completion : @escaping([[Any]]) -> Void,
        _ isAccepted : @escaping(Bool) -> Void
        
    ){
        reviewViewModel.start(populateData(), completion, isAccepted)
    }
    
    func acceptReview(){
        apiClient.start( Dropper.self, request: RequestType.dropBags(getBags()).request) {[weak self] result in
            switch result{
            case .success(_):
                self?.reviewViewModel.acceptReview(true)
            case .failure(let error):
                print("DropViewModel", error)
            }
        }
    }
    
    func getCurrentBags() -> [String]{
        return bagsViewModel.userCurrentBags
    }
    
    private func getBags() -> [String]{
        var data = [String]()
        if let bagsArr = bagsViewModel.bags.value{
            data.append(contentsOf: bagsArr)
        }
        return data
    }
    
    private func populateData() -> [[Any]]{
        var data = [[Any]]()
        if let contactArr = contactViewModel.data.value?.toArr(){
            data.append(contactArr)
        }
        if let addressArr = addressViewModel.address.value?.toArr(){
            data.append(addressArr)
        }
        data.append(getBags())
        return data
    }
}
