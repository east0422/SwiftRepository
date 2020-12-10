//
//  SwiftHello.swift
//  03OCCallSwift
//
//  Created by dfang on 2020-9-1.
//  Copyright © 2020 east. All rights reserved.
//

import Foundation

class SwiftHello: NSObject {
    @objc func say(params:String) -> Void {
        print(params)
    }
    @objc func hi() -> Void {
        print("OC Call Swift hi")
    }
}
