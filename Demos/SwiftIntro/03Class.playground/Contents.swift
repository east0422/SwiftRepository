//: Playground - noun: a place where people can play
// macOS 10.13.6, Xcode 9.4.1, swift 4.1.2

import Foundation

// 枚举
enum CompassPoint {
    case North
    case South
    case East
    case West
}
var direction = CompassPoint.West
direction = .North
// 多个成员值出现在同一行上用逗号隔开
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Nepturn
}
Planet.Earth.rawValue   // 3
Planet.init(rawValue: 2) == Planet.Venus    // true
Planet.init(rawValue: 100) == nil           // true

enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909_51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
switch productBarcode {
case let .UPCA(numberSystem, identifier, check):
    print("UPC-A with value of \(numberSystem)-\(identifier)-\(check).")
case .QRCode(let productCode):
    print("QR code with value of \(productCode).")
}

enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}


// 结构体
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
//rangeOfThreeItems.length = 5  // length let not allow to change
let rangeOfFoutItems = FixedLengthRange.init(firstValue: 1, length: 4)
//rangeOfFoutItems.firstValue = 8 // Cannot assign to property: 'rangeOfFoutItems' is a 'let' constant

struct Resolution {
    var width = 0
    var heigth = 0
}
var somResolution = Resolution.init(width: 300, heigth: 50)
somResolution.heigth = 200


// 类
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
let tenEighty = VideoMode.init()
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
tenEighty === alsoTenEighty // true
//tenEighty == alsoTenEighty    // Binary operator '==' cannot be applied to two 'VideoMode' operands

// 计算属性
struct Point {
    var x = 0.0
    var y = 0.0
}
struct Size {
    var width = 0.0
    var height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 20.0, height: 20.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

// 实例方法中修改值类型
struct Point1 {
    var x = 0.0, y = 0.0
    mutating func moveByX(_ deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point1(x: 1.0, y: 1.0)
somePoint.moveByX(2.0, y: 3.0)

// 类方法
struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func levelIsUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(_ level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
LevelTracker.unlockLevel(8)
LevelTracker.levelIsUnlocked(3)


// 附属脚步
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("3的6倍是\(threeTimesTable[6])") // 3的6倍是18

class Multify {
    var multiplier: Int?
    init() {
    }
    init(multiplier: Int) {
        self.multiplier = multiplier
    }
    subscript(index: Int) -> Int {
        return index * (multiplier ?? 8)
    }
    subscript(index: Int, multify: Int) -> Int {
        return index * multify
    }
}
let multify = Multify.init(multiplier: 6)
print("\(multify[5])") // 30
let multify2 = Multify.init()
print("\(multify2[9])") // 72
print("\(multify2[4,9])")   // 36

// 重写
class Car {
    var speed: Double = 0.0
    init() {
    }
    func description() -> String {
        return "speed: \(speed)mph"
    }
}
class SpeedLimitedCar: Car {
    override var speed: Double {
        get {return super.speed}
        set {super.speed = min(newValue, 40.0)}
    }
}
let limitedCar = SpeedLimitedCar.init()
limitedCar.speed = 60.0
print("SpeedLimitedCar: \(limitedCar.description())")   // SpeedLimitedCar: speed: 40.0mph


// ARC
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
var reference1: Person?
var reference2: Person?
var reference3: Person?
reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1
reference1 = nil
reference2 = nil
print("not deinitialized")
reference3 = nil
