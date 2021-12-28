//
//  DropViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class DropViewModel {
    
    lazy var contactViewModel = ContactViewModel(apiClient)
    lazy var addressViewModel =  AddressViewModel(apiClient)
    lazy var bagsViewModel = BagsViewModel(apiClient)
    lazy var reviewViewModel = ReviewViewModel(apiClient)

    var apiClient : API
    
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
    
    func addBag(
        bagId : String?,
        _ completion: @escaping ([String?])->Void
    ){
        bagsViewModel.addBag(bagId, completion)
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
    
    private func getBags() -> [String]{
        var data = [String]()
        if let bagsArr = bagsViewModel.bags.value{
            let result =  bagsArr.compactMap{$0}
            data.append(contentsOf: result)
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
        
        if let bagsArr = bagsViewModel.bags.value{
            let result =  bagsArr.compactMap{$0}
            data.append(result)
        }
        return data
    }
}
