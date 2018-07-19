//
//  OutputStreamExtensions.swift
//  DirectNetworkConnections
//
//  Created by dfang on 2018-7-27.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

extension OutputStream {
    
    func writeData(data:Data) -> Int {
        let size = data.count
        var completed = 0
        
        print("writeData size:\(size) completed:\(completed)\n")
        while completed < size {
            print("while data:\(data)")
            var wrote = 0
            print("111111")
            data.withUnsafeBytes { (p: UnsafePointer<UInt8>) -> Void in
                print("222222")
                wrote = write(p + completed, maxLength: size - completed)
                print("333333")
            }
            print("wrote: \(wrote)")
            if wrote < 0 {
                return wrote
            } else {
                completed += wrote
            }
        }
        return completed
    }
    
    func writePacketLine(message: String="") -> Int {
        print("writePacketLine msg:\(message)\n")
        let data = message.utf8data
        let length = data.count
        if (length == 0) {
            return writeData(data: "0000".utf8data)
        } else {
            let prefix = (length + 4).toHex(digits: 4).utf8data
            return writeData(data: prefix) + writeData(data: data)
        }
    }
}
