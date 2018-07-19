//
//  InputStreamExtensions.swift
//  DirectNetworkConnections
//
//  Created by dfang on 2018-7-27.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

extension InputStream {
    func readBytes(size:Int) -> [UInt8]? {
        var buffer = Array<UInt8>.init(repeating: 0, count: size)
        var completed = 0
        while completed < size {
            let read = self.read(UnsafeMutablePointer(&buffer) + completed, maxLength: size - completed)
            if read < 0 {
                return nil
            } else {
                completed += read
            }
        }
        return buffer
    }
    
    func readData(size:Int) -> Data? {
        if let buffer = readBytes(size: size) {
            return Data.init(bytes: buffer)
        } else {
            return nil
        }
    }
    
    func readPacketLine() -> Data? {
        if let data = readData(size: 4) {
            let length = data.urf8string.fromHex()
            if length == 0 {
                return nil
            } else {
                return readData(size: (length - 4))
            }
        } else {
            return nil
        }
    }
    
    func readPacketLineString() -> String? {
        if let data = self.readPacketLine() {
            return data.urf8string
        } else {
            return nil
        }
    }
}
