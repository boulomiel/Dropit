//
//  SplashViewModel.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//

import Foundation

struct SplashViewModel {
    
    var observable : Observable<Bool> = Observable(value: false)
    
    func start(
        _ currentValue : Bool,
        _ listener : @escaping ((Bool)->Void)
    ){
        self.observable.value = currentValue
        self.observable.listener = listener
    }
}
