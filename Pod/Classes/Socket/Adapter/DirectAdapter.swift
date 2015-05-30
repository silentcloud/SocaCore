//
//  DirectSocket.swift
//  Soca
//
//  Created by Zhuhao Wang on 2/17/15.
//  Copyright (c) 2015 Zhuhao Wang. All rights reserved.
//

import Foundation

class DirectAdapter : Adapter {
    override func connectToRemote() {
        if connectRequest.config.directConnectWithResolvedIP {
            if connectRequest.IP != nil {
                socket.connectToHost(connectRequest.IP!, withPort: connectRequest.port)
            } else {
                Setup.getLogger().error("DNS look up failed for direct connect to \(self.connectRequest.host), disconnect now")
                connectionDidFail()
            }
        } else {
            socket.connectToHost(connectRequest.host, withPort: connectRequest.port)
        }
    }
    
    override func connectionEstablished() {
        sendResponse(response: nil)
    }

    override func proxySocketReadyForward() {
        readDataForForward()
    }
    
    override func didReadData(data: NSData, withTag tag: Int) {
        if tag == SocketTag.Forward {
            sendData(data)
            readDataForForward()
        }
    }
    
    override func didReceiveDataFromLocal(data: NSData) {
        writeData(data, withTag: SocketTag.Forward)
    }
}