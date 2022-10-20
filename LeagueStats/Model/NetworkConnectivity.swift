//
//  NetworkConnectivity.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 13.10.22..
//

import Foundation
import Alamofire
import UIKit

class NetworkConnectivity {
    
    static let shared = NetworkConnectivity()
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    var isReachable = false
    
    private init() {}
    
    func startListening(){
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch(status) {
            case .notReachable:
                print("not reachable")
                self.isReachable = false
            case .unknown:
                print("unknown")
                self.isReachable = false
            case .reachable(.ethernetOrWiFi):
                print("reachable over wifi / ethernet")
                self.isReachable = true
            case .reachable(.cellular):
                print("reachable over cellular")
                self.isReachable = true
            }
        })
    }
    
    
}

