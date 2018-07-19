//
//  PacketLineParser.swift
//  DirectNetworkConnections
//
//  Created by dfang on 2018-7-27.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class PacketLineParser: NSObject, StreamDelegate {
    let output:OutputStream
    let callback:(String)->()
    var capture:PacketLineParser?
    
    init(_ output: OutputStream, _ callback:@escaping (String) -> ()) {
        self.output = output
        self.callback = callback
        super.init()
        capture = self
    }
    
    func stream(_ stream: Stream, handle handleEvent: Stream.Event) {
        print("   stream aaaa")
        let input = stream as! InputStream
        if handleEvent == Stream.Event.hasBytesAvailable {
            if let line = input.readPacketLineString() {
                callback(line)
            } else {
                closeStreams(input, output)
            }
        }
        if (handleEvent == Stream.Event.endEncountered || handleEvent == Stream.Event.errorOccurred) {
            closeStreams(input, output)
        }
    }
    
    func closeStreams(_ input:InputStream, _ output:OutputStream) {
        print("closeStreams")
        if capture != nil {
            capture = nil
            output.remove(from: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
            input.remove(from: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
            input.delegate = nil
            output.delegate = nil
            if output.streamStatus != Stream.Status.closed {
                output.writePacketLine()
                output.close()
            }
            if input.streamStatus != Stream.Status.closed {
                input.close()
            }
        }
    }
    
}
