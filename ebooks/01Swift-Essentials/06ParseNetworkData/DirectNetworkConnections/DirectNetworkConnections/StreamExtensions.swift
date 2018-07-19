//
//  StreamExtensions.swift
//  DirectNetworkConnections
//
//  Created by dfang on 2018-7-27.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

extension Stream {
    class func open(hostname: String, andPort port: Int) -> (InputStream, OutputStream)? {
        if let (input, output) = connect(hostname: hostname, andPort: port) {
            input.open()
            output.open()
            return (input, output)
        } else {
            return nil
        }
    }
    
     class func connect(hostname: String, andPort port: Int) -> (InputStream, OutputStream)? {
        var input: InputStream?
        var output: OutputStream?
        
        Stream.getStreamsToHost(withName: hostname, port: port, inputStream: &input, outputStream: &output)
        if (input == nil || output == nil) {
            return nil
        } else {
            return(input!, output!)
        }
    }
}
