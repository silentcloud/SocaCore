//
//  BlackHoleAdapter.swift
//  Pods
//
//  Created by Zhuhao Wang on 5/14/15.
//
//

import Foundation

class BlackHoleAdapter : Adapter {
    override func connectToRemote() {
        connectionDidFail()
    }
}