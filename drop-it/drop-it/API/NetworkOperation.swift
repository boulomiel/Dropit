//
//  NetworkOperation.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//

import Foundation

class NetworkOperation <T: DropCodable> : Operation{
    private let lockQueue = DispatchQueue(label: "com.networkOperationQueue", attributes: .concurrent)

    var data : T.Type
    var requestType : RequestType
    
    private var _isExecuting: Bool = false
    override private(set) var isExecuting: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync(flags: [.barrier]) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Bool = false
    override private(set) var isFinished: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync(flags: [.barrier]) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isAsynchronous: Bool{
        return true
    }
    
    init(data : T.Type,
         requestType : RequestType,
         completionBlock : (()->Void)? = nil) {
        self.data =  data.self
        self.requestType =  requestType
        super.init()
        self.completionBlock =  completionBlock
    }
    
    override func start() {
        print("Starting")
         isFinished = false
         isExecuting = true
         main()
    }
    
    override func main() {
            print("Executing")
            API.shared.start(data, request: requestType.request){[weak self]result in
                switch result{
                case .success(let data):
                    if let data  = data{
                        self?.requestType.repository.create(data)
                    }
                case .failure(let error):
                    print(error)
                }
                self?.finish()
            }
    }

    func finish() {
        print("Finish")
        isExecuting = false
        isFinished = true
    }
}
