//
//  Codable.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation

extension DropCodable{
    
    func toDict() -> [String : Any]{
            var dict : [String : Any] =  [:]
            let mirrored =  Mirror.init(reflecting: self)
            mirrored.children.forEach { child in
                if let label = child.label {
                    if let dropCodableChild = child.value as? DropCodable{
                       let childDict =  dropCodableChild.toDict()
                        dict[label] =  childDict
                    }else if let dropCodableChild = child.value as? [DropCodable]{
                        let childDictArr : [[String : Any]] =  dropCodableChild.map{$0.toDict()}
                        dict[label] =  childDictArr
                    } else {
                        dict[label] = child.value
                    }
                }
            }
            return dict
        }
    
    func toArr()->[String]{
        var arr = [String?]()
        let mirrored =  Mirror.init(reflecting: self)
        mirrored.children.forEach { child in
            if let _ = child.label {
                if let dropCodableChild = child.value as? DropCodable{
                   let childArr =  dropCodableChild.toArr()
                    arr.append(contentsOf: childArr)
                }else if let dropCodableChild = child.value as? [DropCodable]{
                    let childArr =  dropCodableChild.map{$0.toArr()}
                    for child in childArr {
                        arr.append(contentsOf: child )
                    }
                } else {
                    arr.append("\(child.value)")
                }
            }
        }
        let result = arr.compactMap{$0}
        return result
    }
}

