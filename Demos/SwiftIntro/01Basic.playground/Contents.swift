//: Playground - noun: a place where people can play
// macOS 10.13.6, Xcode 9.4.1, swift 4.1.2

import UIKit

// 字符串插值
let str1 = "str1"
print("str1 is:\(str1)")
let multiplier = 3
let message = "\(multiplier) * 2.5 = \(Double(multiplier) * 2.5)"


// 分号
let cat = "cat"; print(cat)


// 字面量
let p1 = 0xFp2  // 60
//let p2 = 8p2    // compile fail
let e1 = 0xe2 // 226
let e2 = 5e2   // 500
let ep1 = 0xC.3P0   // (12 + 3/16) * 2^0 = 12.1875
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_00_000.000_1


// 元组
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error
var person:(Int, String) = (age: 23, name: "lily")
print(http404Error) // (404, "Not Found")
print("code is \(statusCode)") // "The status code is 404"
print("message is \(statusMessage)") // "The status message is Not Found"
let (justTheStatusCode, _) = http404Error
print("code is \(justTheStatusCode)")

print("code is \(http404Error.0)")
print("message is \(http404Error.1)")

let http200Status = (statusCode: 200, description: "OK")
print("code is \(http200Status.statusCode)")
print("message is \(http200Status.description)")


// 断言
let age = -3
//assert(age >= 0, "A person's age cannot be less than zero ") // assertion failed
print("age is:\(age)")

// 基本运算符
// 空合运算符??， 前面的如果为nil，就将后面设为其默认值。前面必须是?类型且后面值和前面表达式类型需一致
var cc:String?
var sa = cc ?? "aaa"

// 溢出运算符
let x = 8 &+ 2 // 10
let x1 = UInt8.max &+ 1  // 0
let x2 = UInt8.min &- 1 // 255
let x3 = Int8.max &+ 1  // -128
let x4 = Int8.min &- 2  // 126


// 求余
5 % 2  // 1
5 % -2  // 1
-5 % 2  // -1
-5 % -2 // -1
18.5.truncatingRemainder(dividingBy: 3) // 0.5
18.5.truncatingRemainder(dividingBy: -3) // 0.5
-18.5.truncatingRemainder(dividingBy: 3) // -0.5
-18.5.truncatingRemainder(dividingBy: -3) // -0.5

1...5   // [1,2,3,4,5]
1..<3   // [1,2]


// 字符串
"" == String()  // true
for c in "abc" {
    print(c)
}

"abc你好".count // 5
"abc你好".lengthOfBytes(using: String.Encoding.utf8)  // 9
"abc你好".lengthOfBytes(using: String.Encoding.utf16)  // 10
"abc你好".lengthOfBytes(using: String.Encoding.ascii) // 0


//  unicode
let dog = "Dog!黄"
for codeUnit in dog.utf8 {  // 68 111 103 33 233 187 132
    print(codeUnit)
}
for codeUnit in dog.utf16 {  // 68 111 103 33 40644
    print(codeUnit)
}
for codeUnit in dog.unicodeScalars {  // D o g ! 黄
    print(codeUnit)
}


// 数组
var shoppingList: [String] = ["Eggs", "Milk"]
shoppingList += ["Apple", "Banana"]
shoppingList.append("Rice")
shoppingList[1...3] = ["Orange"]
shoppingList.isEmpty
shoppingList.count
for (index, value) in shoppingList.enumerated() {
    print("index:\(index) and value:\(value)")
}


// 字典
var dics = ["TYO": "Tokyo", "DUB": "Dublin"]
for (key, value) in dics {
    print("key:\(key), value:\(value)")
}
let keys = Array(dics.keys) // ["DUB", "TYO"]
let values = Array(dics.values) // ["Dublin", "Tokyo"]


