//
//  RepositoryAccessor.swift
//  drop-it
//
//  Created by Ruben Mimoun on 11/01/2022.
//

import Foundation

protocol RepositoryAccessor{}

extension RepositoryAccessor{
    
    private var dropitRepository : DropItRepository{
        return DropItRepository()
    }
    
    var contactDetails : User{
        dropitRepository.userRepository.fetchAll().first ?? dropitRepository.getJsonLocalData().contactDetails
    }
    
    var addressDetails : Address{
        dropitRepository.addressRepository.fetchAll().first ?? dropitRepository.getJsonLocalData().address
    }
    
    var bags : [String]{
        dropitRepository.getBags()
    }
    
    func saveNewDropper(dropper : Dropper){
        dropitRepository.removeAll()
        dropitRepository.userRepository.create(dropper.contactDetails)
        dropitRepository.addressRepository.create(dropper.address)
        dropper.bags.forEach { brand in
            dropitRepository.bagsRepository.create(Bag(name: brand))
        }
    }
    
    func createUser(user : User){
        dropitRepository.userRepository.create(user)
    }
    
    func createAddress(address : Address){
        dropitRepository.addressRepository.create(address)
    }
    
    func createBag(bag : Bag){
        dropitRepository.bagsRepository.create(bag)
    }
    
    func removeBags(){
        dropitRepository.bagsRepository.removeAll()
    }
}

