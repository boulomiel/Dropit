//
//  AddressViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class AddressViewModel  : RepositoryAccessor{
    
    var address : Observable<Address> = Observable(value: nil)
    var addressUpdated : Observable<Bool?> = Observable(value: false)

    var addressOperation : NetworkOperation<Address>?

    func start(
        _ completionAddress : @escaping((Address?)->Void),
        _ completionAddressUpdate : @escaping(Bool?) -> Void
    ){
        address.listener = completionAddress
        addressUpdated.listener = completionAddressUpdate
        address.value = addressDetails
    }
    
    func update(_ address : Address){
        addressOperation =  NetworkOperation(data: Address.self, requestType: .updateShippingAddress(address), completionBlock: {
            DispatchQueue.main.async {[weak self] in
                self?.createAddress(address: address)
                self?.addressUpdated.value = true
                self?.address.value = address
            }
        })
        addressOperation?.start()
    }
}


