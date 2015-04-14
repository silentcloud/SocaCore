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
import MagicalRecord
import CoreData

class ConfigSpec: QuickSpec {
    override func spec() {
        describe("MagicalRecord") {
            it("should be able to set up CoreData") {
                let location = NSBundle(forClass: DirectAdapterConfig.self)
                let model = NSManagedObjectModel.mergedModelFromBundles([location])!
                NSManagedObjectModel.MR_setDefaultManagedObjectModel(model)
                MagicalRecord.setupAutoMigratingCoreDataStack()
                expect(DirectAdapterConfig.MR_countOfEntities()).toNot(raiseException())
            }
        }
    }
}