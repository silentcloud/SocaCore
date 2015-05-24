//
//  PACServer.swift
//  Pods
//
//  Created by Zhuhao Wang on 5/16/15.
//
//

import Foundation

class PACServer : BaseServer, SocketDelegate {
    let headerTag = 1
    let contentTag = 2
    let fileURL: NSURL
    lazy var fileData: NSData = {
        [unowned self] in
        return NSData(contentsOfURL: self.fileURL)!
    }()
    
    init(listenOnPort port: Int, withPACFile fileURL: NSURL) {
        self.fileURL = fileURL
        super.init(listenOnPort: port)
    }
    
    override func didAcceptNewSocket(newSocket: Socket, withSocket socket: GCDAsyncSocket) {
        newSocket.socketDelegate = self
        addSocket(newSocket)
        newSocket.readDataToData(Utils.HTTPData.DoubleCRLF, withTag: headerTag)
    }
    
    func socket(socket: Socket, didReadData: NSData, withTag: Int) {
        sendPACFileToSocket(socket)
        socket.readDataToData(Utils.HTTPData.DoubleCRLF, withTag: headerTag)
    }
    
    func sendPACFileToSocket(socket: Socket) {
        socket.writeData("HTTP/1.1 200 OK\r\n".toUTF8Data()!, withTag: headerTag)
        socket.writeData("Content-Length: \(fileData.length)\r\n".toUTF8Data()!, withTag: headerTag)
        socket.writeData("Content-Type: application/x-ns-proxy-autoconfig\r\n\r\n".toUTF8Data()!, withTag: headerTag)
        socket.writeData(fileData, withTag: contentTag)
    }
    
    func socket(socket: Socket, didWriteDataWithTag: Int) {

    }
    
    func socket(socket: Socket, didConnectToHost: String, onPort: Int) {
        
    }
    
    func socket(socket: Socket, didDisconnectWithError: NSError?) {
        socketDidDisconnect(socket)
    }
}