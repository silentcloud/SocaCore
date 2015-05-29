//
//  DNSFailRule.swift
//  Pods
//
//  Created by Zhuhao Wang on 5/26/15.
//
//

import Foundation

class DNSFailRule : AllRule {
    override func match(request: ConnectRequest) -> AdapterFactory? {
        if request.IP == "" {
            return adapterFactory
        }
        return nil
    }
}