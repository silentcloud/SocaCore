//
//  ConnectRequest.swift
//  SocaCore
//
//  Created by Zhuhao Wang on 2/18/15.
//  Copyright (c) 2015 Zhuhao Wang. All rights reserved.
//

import Foundation

class ConnectMessage {
    enum Method : Int {
        case HTTP_CONNECT, HTTP_REQUEST, SOCKS5
    }
    
    let host: String
    let port: Int
    let method: Method
    let config: Config
   
    lazy var IP: String? = {
        [unowned self] in
        return self._getIP()
    }()
    
    lazy var country: String = {
        [unowned self] in
        if let ip = self.IP {
            return Utils.GeoIPLookup.Lookup(ip)
        }
        return ""
    }()
    
    init(host: String, port: Int, method: Method, withConfig config: Config) {
        self.host = host
        self.port = port
        self.method = method
        self.config = config
    }
    
    private func _getIP() -> String?{
        if isIP() {
            return host
        } else {
            return config.dnsResolver.resolve(host)
        }
    }
    
    func isIPv4() -> Bool {
        return Utils.IP.isIPv4(host)
    }
    
    func isIPv6() -> Bool {
        return Utils.IP.isIPv6(host)
    }
    
    func isIP() -> Bool {
        return isIPv4() || isIPv6()
    }
}