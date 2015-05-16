//
//  StringExtention.swift
//  Pods
//
//  Created by Zhuhao Wang on 5/16/15.
//
//

import Foundation

extension String {
    func toUTF8Data() -> NSData? {
        return self.dataUsingEncoding(NSUTF8StringEncoding)
    }
}