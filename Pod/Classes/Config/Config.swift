//
//  Config.swift
//  Pods
//
//  Created by Zhuhao Wang on 5/30/15.
//
//

import Foundation

class Config {
    var dnsResolver: DNSResolver
    var directConnectWithResolvedIP: Bool
    
    init() {
        dnsResolver = DNSResolver()
        directConnectWithResolvedIP = true
    }
}