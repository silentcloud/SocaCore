//
//  Profile.swift
//  soca
//
//  Created by Zhuhao Wang on 4/2/15.
//  Copyright (c) 2015 Zhuhao Wang. All rights reserved.
//

import Foundation

/**
 *  Profile holds the set of proxies with specific rules you would like to run simutaneouly.
*/
public class Profile {
    public let config: ProfileConfig
    public var running = false
    
    lazy var servers: [ProxyServer] = {
        [unowned self] in
        self.config.proxies.allObjects.map() {
            ($0 as! ProxyConfig).proxyServer()
        }
    }()
    
    lazy var pacServer: PACServer? = {
        [unowned self] in
        if self.config.pacServerPort == 0 || self.config.pacFilePath == nil {
            return nil
        }
        return PACServer(listenOnPort: self.config.pacServerPort, withPACFile: self.config.pacFilePath)
    }()
    
    init(profileConfig: ProfileConfig) {
        self.config = profileConfig
    }
    
    public func start() {
        for server in servers {
            server.startProxy()
        }
        if config.pacServerEnabled {
            pacServer?.startProxy()
        }
        running = true
    }
    
    public func stop() {
        for server in servers {
            server.stopServer()
        }
        pacServer?.stopServer()
        running = false
    }
}