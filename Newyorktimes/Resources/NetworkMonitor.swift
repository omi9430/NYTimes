//
//  NetworkManager.swift
//  Newyorktimes
//
//  Created by omair khan on 22/11/2021.
//

import Foundation
import Network

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let  monitor : NWPathMonitor
    
    
    //Any one read but not change the value
    public private(set) var isConnected : Bool = false
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(completion : @escaping(Bool) ->  Void){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected  = path.status != .unsatisfied
            if self?.isConnected == true {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    public func stopMonitoring(){
        monitor.cancel()
    }
}
