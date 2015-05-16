//
//  Rule.swift
//  Soca
//
//  Created by Zhuhao Wang on 2/17/15.
//  Copyright (c) 2015 Zhuhao Wang. All rights reserved.
//

import Foundation

protocol RuleProtocol : class {
    var name: String? { get set }
    
    func match(request: ConnectRequest) -> AdapterFactory?
}

class Rule : RuleProtocol {
    var name: String?
    
    init() {
        name = nil
    }
    
    func match(request: ConnectRequest) -> AdapterFactory? {
        return nil
    }
}

class AllRule : Rule {
    let adapterFactory: AdapterFactory
    
    init(adapterFactory: AdapterFactory) {
        self.adapterFactory = adapterFactory
        super.init()
    }

    override func match(request: ConnectRequest) -> AdapterFactory? {
        return adapterFactory
    }
}

class DirectRule : AllRule {
    init() {
        super.init(adapterFactory: DirectAdapterFactory())
    }
}

