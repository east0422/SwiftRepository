//
//  RemoteGitRepository.swift
//  DirectNetworkConnections
//
//  Created by dfang on 2018-7-27.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

class RemoteGitRepository {
    let host:String
    let repo:String
    let port:Int
    
    init(host:String, repo:String, _ port:Int = 9418) { // 9418 is the default for the git:// protocol
        self.host = host
        self.repo = repo
        self.port = port
    }
    
    func lsRemoteAsync(fn:@escaping (String,String) -> ()) {
        if let (input,output) = Stream.connect(hostname: host, andPort: port) {
            print("lsRemoteAsync")
            input.delegate = PacketLineParser(output) {
                (response:String) -> () in
                print("response:\(response)")
                let index = response.index(response.startIndex, offsetBy: 41)
                let hash = String.init(response[..<index])
                let ref = String.init(response[index...])
                if !ref.hasPrefix("HEAD") {
                    fn(ref,hash)
                }
            }
            input.schedule(in: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
            input.open()
            output.open()
            output.writePacketLine(message: "git-upload-pack \(repo)\0host=\(host)\0")
        }
    }
    
    func lsRemote() -> [String:String] {
        var refs = [String:String]()
        if let (input,output) = Stream.open(hostname: host, andPort: port) {
            output.writePacketLine(message: "git-upload-pack \(repo)\0host=\(host)\0")
            while true {
                if let response = input.readPacketLineString() {
                    let index = response.index(response.startIndex, offsetBy: 41)
                    let hash = String.init(response[..<index])
                    let ref = String.init(response[index...])
                    if ref.hasPrefix("HEAD") {
                        continue
                    } else {
                        refs[ref] = hash
                    }
                } else {
                    break
                }
            }
            output.writePacketLine()
            input.close()
            output.close()
        }
        
        return refs
    }
}
