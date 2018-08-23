//: Playground - noun: a place where people can play
// macOS 10.13.6, Xcode 9.4.1, swift 4.1.2

import Foundation

// 有参有一个返回值
func sayHello(name: String) -> String {
    let gretting = "Hello, \(name)!"
    return gretting
}
print(sayHello(name: "Xiaoming"))

// 有参数返回多个值
func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
    var vowels = 0
    var consonants = 0
    var others = 0
    for character in string {
        switch String(character).lowercased() {
            case "a", "e", "i", "o", "u":
                vowels += 1
            case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
                 "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
                consonants += 1
            default:
                others += 1
        }
    }
    return (vowels: vowels, consonants: consonants, others: others)
}
let total = count(string: "some arbitrary string!")
let (vowels, consonants, others) = count(string: "some arbitrary string!")
print("\(vowels) vowels and \(consonants) consonants and others is \(others)")

// 省略参数名及默认参数值
func join(_ str1: String, _ str2: String, withJoiner joiner: String = "-") -> String {
    return str1 + joiner + str2
}
let helloWorld = join("Hello", "world!", withJoiner: ",")
func join(_ str1: String, _ str2: String, joiner: String = "-") -> String {
    return str1 + joiner + str2
}
let sayhi = join("Say", "Hi", joiner: "-")

// 可变参数
func sum(numbers: Double...) -> Double {
    var total:Double = 0
    for number in numbers {
        total += number
    }
    return total
}
print(sum(numbers: 1, 3, 5))    // 9.0
print(sum(numbers: 2, 3))   // 5.0

// 输入输出参数
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a=b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

// 函数类型作为参数类型
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int)
{
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)

// 函数类型作为返回值类型
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(_ backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}
var currentValue = -3
let moveNearerToZero = chooseStepFunction(currentValue > 0)
let step = moveNearerToZero(currentValue)

// 嵌套函数
func changeStep(_ isPositive: Bool) -> (Int) -> Int {
    func increase(input: Int) -> Int {
        return input + 1
    }
    func decrease(input: Int) -> Int {
        return input - 1
    }
    
    return isPositive ? decrease : increase
}
var curValue = 4
let moveToZero = changeStep(curValue > 0)
while curValue != 0 {
    print("\(curValue)... ")
    curValue = moveToZero(curValue)
}


// 闭包
var names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
names.sort()    // 字母顺序排列
names.sort(by: backwards(s1:s2:)) // 按字母反序排列
names.sort { (s1, s2) -> Bool in
    return s1 > s2
}
// 闭包隐式返回
names.sort { s1, s2 in
    s1 < s2
}
