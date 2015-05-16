//
//  PACManager.swift
//  Pods
//
//  Created by Zhuhao Wang on 5/16/15.
//
//

import Foundation

public struct PACManager {
    static var server: PACServer?
    
    public static func startServerOnPort(port: Int, withPACFile file: String) {
        stopServer()
        server = PACServer(listenOnPort: port, withPACFile: file)
        server!.startProxy()
    }
    
    public static func stopServer() {
        server?.stopServer()
        server = nil
    }
}