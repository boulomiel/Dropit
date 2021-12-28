//
//  AddressViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class AddressViewModel {
    var apiClient : API
    var address : Observable<Address> = Observable(value: nil)
    var addressUpdated : Observable<Bool?> = Observable(value: false)

    init(_ apiClient : API){
        self.apiClient = apiClient
    }
    
    func start(
        _ completionAddress : @escaping((Address?)->Void),
        _ completionAddressUpdate : @escaping(Bool?) -> Void
    ){
        address.listener = completionAddress
        addressUpdated.listener = completionAddressUpdate
        apiClient.start(Address.self, request: RequestType.getShippingAddress.request) {[weak self] result in
            switch result{
            case .success(let address):
                self?.address.value = address
            case .failure(let error):
                print("AddressViewModel", error)
            }
        }
    }
    
    func update(_ address : Address){
        apiClient.start(Address.self, request: RequestType.updateShippingAddress(address).request) {[weak self] result in
            switch result{
            case .success(_):
                self?.addressUpdated.value = true
                self?.address.value = address
            case .failure(let error):
                print("AddressViewModel", error)
            }
        }
    }
}


