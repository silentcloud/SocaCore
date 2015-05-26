//
//  ConfigTest.swift
//  SocaCore
//
//  Created by Zhuhao Wang on 4/11/15.
//  Copyright (c) 2015 Zhuhao Wang. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SocaCore

class ConfigSpec: QuickSpec {
    override func spec() {
        describe("ConfigParse") {
            it("should be able to load config file from json") {
                let bundle = NSBundle(forClass: ConfigSpec.self)
                let configURL = bundle.URLForResource("config_example", withExtension: "json")!
                let profile = ConfigParser.loadProfile(configURL)
//                expect(profile!.pacServer).toNot(beNil())
//                expect(profile).to(equal(1))
            }
        }
    }
}