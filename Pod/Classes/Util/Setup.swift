//
//  Setup.swift
//  Pods
//
//  Created by Zhuhao Wang on 4/14/15.
//
//

import Foundation
import XCGLogger

public class Setup {
    public class func getLogger() -> XCGLogger {
        return XCGLogger.defaultInstance()
    }
}