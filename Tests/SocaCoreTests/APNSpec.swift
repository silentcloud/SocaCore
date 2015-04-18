//
//  APNSpec.swift
//  SocaCore
//
//  Created by Zhuhao Wang on 15/4/18.
//  Copyright (c) 2015年 Zhuhao Wang. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SocaCore

class APNSpec : QuickSpec {
    override func spec() {
        describe("APN") {
            it("should be able to set port and name") {
                let apn = APN()
                apn.setAPN(1984, andAPN: "3gnet")
            }
        }
    }
}