//
//  ProxyServer.swift
//  SocaCore
//
//  Created by Zhuhao Wang on 2/16/15.
//  Copyright (c) 2015 Zhuhao Wang. All rights reserved.
//

import Foundation

/**
 * ProxyServer is the base proxy server that accepts requests from your device and forwards the requests to remote proxies or remote servers directly based on rules represented by RuleManager.
*/
class ProxyServer : BaseServer {
    let ruleManager: RuleManager

    init(listenOnPort port: Int, withRuleManager ruleManager: RuleManager) {
        self.ruleManager = ruleManager
    
        super.init(listenOnPort: port)
    }
    
    func matchRule(request: ConnectRequest) -> AdapterFactory {
        return ruleManager.match(request)
    }
}

/**
 *  The SOCKS5 proxy server.
*/
class SOCKS5ProxyServer : ProxyServer {
    override func didAcceptNewSocket(newSocket: Socket, withSocket socket: GCDAsyncSocket) {
        let proxySocket = SOCKS5ProxySocket(socket: newSocket, proxy:self)
        addSocket(proxySocket)
        proxySocket.openSocket()
    }
}

/**
 *  The HTTP proxy server.
*/
class HTTPProxyServer : ProxyServer {
    override func didAcceptNewSocket(newSocket: Socket, withSocket socket: GCDAsyncSocket) {
        let proxySocket = HTTPProxySocket(socket: newSocket, proxy: self)
        addSocket(proxySocket)
        proxySocket.openSocket()
    }
}