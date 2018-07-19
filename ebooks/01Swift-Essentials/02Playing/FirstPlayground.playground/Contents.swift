//: Playground - noun: a place where people can play

// UIKit for iOS and AppKit for macOS
import UIKit
import Foundation

var str = "Hello, playground"
print(str)

for i in 1...12 {
    let j = (i - 7) * (i - 6)
    print("i is \(i) and j is \(j)")
}

let rect = CGRect.init(x: 0, y: 0, width: 200, height: 100)
let label = UILabel.init(frame: rect)
label.text = str
label.textColor = UIColor.blue
label.backgroundColor = UIColor.red
label.font = UIFont.systemFont(ofSize: 20)

let bgImage = UIImage.init(named: "bg")

import PlaygroundSupport
let page = PlaygroundPage.current

// When liveView is set to a non-nil value the system sets needsIndefiniteExecution to true
page.liveView = label
page.liveView = UIImageView.init(image: bgImage)

// A Boolean value that indicates whether indefinite execution is enabled
page.needsIndefiniteExecution = true
let queue: DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
let group: DispatchGroup = DispatchGroup.init()
func test() {
    queue.async (group: group, execute: {
        var str: String = "AA"
        for i in 1...9 {
            str.append("\(i)")
        }
        print("A finished and str is \(str)")
//        page.finishExecution()
    })
    queue.async (group: group, execute:{
        var str: String = "BB"
        for i in 1...9 {
            str.append("\(i)")
        }
        print("B finished and str is \(str)")
//        page.finishExecution()
    })
    group.notify(queue: DispatchQueue.global()) {
        print("done")
        page.finishExecution()
    }
}
test()
