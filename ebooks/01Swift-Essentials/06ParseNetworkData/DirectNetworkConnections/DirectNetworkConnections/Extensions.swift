//
//  Extensions.swift
//  DirectNetworkConnections
//
//  Created by dfang on 2018-7-27.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

extension Data {
    var urf8string: String {
        return String.init(data: self, encoding: String.Encoding.utf8)!
    }
}

extension Int {
    func toHex(digits: Int) -> String {
        return String.init(format: "%0\(digits)x", self)
    }
}

extension String {
    var utf8data: Data {
        return self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
    }
    
    func fromHex() -> Int {
        var result = 0
        self.forEach { (c) in
            result *= 16
            switch c {
                case "0": result += 0
                case "1": result += 1
                case "2": result += 2
                case "3": result += 3
                case "4": result += 4
                case "5": result += 5
                case "6": result += 6
                case "7": result += 7
                case "8": result += 8
                case "9": result += 9
                case "a", "A": result += 10
                case "b", "B": result += 11
                case "c", "C": result += 12
                case "d", "D": result += 13
                case "e", "E": result += 14
                case "f", "F": result += 15
                default: break
            }
        }
        return result
    }
}
