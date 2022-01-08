//
//  DropViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class DropViewModel {
    
    lazy var dropitRepository =  DropItRepository()
    var tableData : Observable<[[Any]]>  = Observable(value: [])
    var isAccepted : Observable<Bool>  = Observable(value: false)
    var dropperOperation : NetworkOperation<Dropper>?
    
    func start(
        _ completion : @escaping([[Any]]) -> Void,
        _ completionAccepted : @escaping(Bool) -> Void

    ){
        tableData.listener = completion
        tableData.value = dropitRepository.getAllData()
        isAccepted.listener = completionAccepted
    }
    
    func update(){
        dropperOperation =  NetworkOperation(data: Dropper.self, requestType: .dropBags(dropitRepository.getBags()), completionBlock: {[weak self] in
            self?.isAccepted.value =  true
        })
        dropperOperation?.start()
    }
}
