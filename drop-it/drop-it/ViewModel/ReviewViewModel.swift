//
//  ReviewViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
class ReviewViewModel {
    
    var tableData : Observable<[[Any]]>  = Observable(value: [])
    var isAccepted : Observable<Bool>  = Observable(value: false)
    
    func start(
        _ data : [[Any]],
        _ completion : @escaping([ [Any]]) -> Void,
        _ completionAccepted : @escaping(Bool) -> Void
    ){
        tableData.listener = completion
        isAccepted.listener = completionAccepted
        tableData.value = data
    }
    
    func acceptReview(
        _ accepted : Bool
    ){
        isAccepted.value = accepted
    }
}
    
