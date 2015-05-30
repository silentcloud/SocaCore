//
//  DNSResolver.swift
//  Pods
//
//  Created by Zhuhao Wang on 5/29/15.
//
//

import Foundation

class DNSResolver {
    let timeout: Double
    
    init(timeout: Double = -1.0) {
        self.timeout = timeout
    }
    
    func resolve(name: String) -> String? {
        return Utils.DNS.resolve(name, timeout: timeout)
    }
}