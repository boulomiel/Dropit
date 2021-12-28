//
//  Observable.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

class Observable<T> {
    
    var value : T?{
        didSet{
            if let value = value {
                listener?(value)
            }
        }
    }
    
    init(value : T?){
        self.value = value
    }
    
    var listener : ((T)->Void)?
    
    func bind(_ listener : @escaping((T?)->Void)){
        listener(value)
        self.listener = listener
    }
    
}
