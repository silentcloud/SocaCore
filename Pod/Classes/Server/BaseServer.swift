//
//  Server.swift
//  Pods
//
//  Created by Zhuhao Wang on 5/16/15.
//
//

import Foundation

class BaseServer : NSObject, GCDAsyncSocketDelegate {
    let listeningPort: Int
    var activeSockets: [SocketProtocol] = [SocketProtocol]()
    var listeningSocket: GCDAsyncSocket!
    var listeningQueue: dispatch_queue_t = dispatch_queue_create("com.Soca.Server.listenQueue", DISPATCH_QUEUE_SERIAL)
    var socketModifyQueue: dispatch_queue_t = dispatch_queue_create("com.Soca.Server.socketModifyQueue", DISPATCH_QUEUE_SERIAL)
    
    init(listenOnPort port: Int) {
        self.listeningPort = port
        
        super.init()
    }
    
    func startProxy() -> NSError? {
        stopServer()
        listeningSocket = GCDAsyncSocket(delegate: self, delegateQueue: self.listeningQueue)
        var error: NSError?
        listeningSocket.acceptOnPort(UInt16(self.listeningPort), error: &error)
        return error
    }
    
    func didAcceptNewSocket(newSocket: Socket, withSocket socket: GCDAsyncSocket) {}
    
    func stopServer() {
        listeningSocket?.disconnect()
        listeningSocket?.delegate = nil
        listeningSocket = nil
        
        // make sure the socket finish disconnecting
        NSThread.sleepForTimeInterval(0.01)
        
        dispatch_sync(listeningQueue) {
            [unowned self] in
            for socket in self.activeSockets {
                socket.disconnect()
            }
        }
    }
    
    func addSocket(socket: SocketProtocol) {
        dispatch_async(socketModifyQueue) {
            [unowned self] in
            self.activeSockets.append(socket)
        }
    }
    
    func removeSocket(socket: SocketProtocol) {
        dispatch_async(socketModifyQueue) {
            [unowned self] in
            for index in (0..<self.activeSockets.count) {
                if self.activeSockets[index] === socket {
                    self.activeSockets.removeAtIndex(index)
                    return
                }
            }
        }
    }
    
    // MARK: Delegate method for server
    func socketDidDisconnect(socket: SocketProtocol) {
        removeSocket(socket)
    }
    
    // MARK: Delegate method for GCDAsyncSocket
    func socket(sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        didAcceptNewSocket(Socket(socket: newSocket), withSocket: sock)
    }
}
