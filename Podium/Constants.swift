//
//  Constants.swift
//  DebatesApp
//
//  Created by Jorge Soler on 10/11/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import Foundation
import SystemConfiguration
    
    let BASE_URL = "http://debatesapp.azurewebsites.net/podiumwebapp/ws"
    let LOGIN_URL = "/user/login?"
    let EMAIL_URL = "email="
    let PASS_URL = "&password="

typealias DownloadComplete = () -> ()

public class Reachability {
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
    
    
