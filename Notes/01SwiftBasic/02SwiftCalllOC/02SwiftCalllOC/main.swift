//
//  main.swift
//  02SwiftCalllOC
//
//  Created by dfang on 2020-9-1.
//  Copyright © 2020 east. All rights reserved.
//

import Foundation

// 调用OC对象方法
let hello = OCHello()
hello.say() // Swift call OC say
hello.print("mock参数") // Swict call OC print: with mock参数

class Hi {
    var _name:String? = "swift"
    
    init() {
    
    }
    
    init(name:String) {
        _name = name;
    }
    
    func say() -> Void {
        print("hi \(_name!)")
    }
    
    // 类方法
    class func sayMorning() -> Void {
        print("hi morning")
    }
}
//let hi = Hi()
let hi = Hi(name:"east")
hi.say() // hi swift / hi east
Hi.sayMorning() // hi morning

// 命名空间
class com {
    class east {
        class Hello {
            func sayHello() -> Void {
                print("com.east.Hello sayHello")
            }
        }
    }
}

extension com.east {
    class Hi {
        func sayHi() -> Void {
            print("com.east.Hi sayHi")
        }
    }
}

let hello1 = com.east.Hello()
hello1.sayHello() // com.east.Hello sayHello
let hi1 = com.east.Hi()
hi1.sayHi() // com.east.Hi sayHi
