//
//  main.swift
//  01DataType
//
//  Created by dfang on 2020-9-1.
//  Copyright © 2020 east. All rights reserved.
//

import Foundation

// 变量var, 常量let
var hello = "hello"
hello += " world!"
// 不推荐关键字作为标识符，非要使用的话使用``包起来
var `class` = 3
// 🐶属于Unicode字符
let 🐶 = "dog"
// 常量不可再被改变
let hi = "hi"
//hi += " swift!" // compile error: hi is constant and immutable
print("\(hello), \(`class`), \(hi), \(🐶)") // hello world!, 3, hi, dog

// 整型
let oneMillion = 1_000_000
let help = 0110
print(oneMillion,help) // 1000000 110
// 整型之间必须显示转换
var num1: Int16 = 100
var num2: Int32 = 200
//var num3 = num1 + num2 // compile error: Binary operator '+' cannot be applied to operands of type 'Int16' and 'Int32'
var num3 = Int32(num1) + num2
var num4 = num1 + Int16(num2)
print(num3, num4) // 300 300

// 浮点型
var w = -4.0 / 0.0 // 负无穷大
var noneNum = 0.0 / 0.0 // 非数字
print(w, noneNum) // -inf nan

// 元组
var score:(String, (Float, String)) = ("语文", (140, "优秀"))
print(score, score.1.0) // ("语文", (140.0, "优秀")) 140.0

// 可选类型
var str = "hello123"
var optionNum: Int? = Int(str)
print(optionNum as Any) // nil

// 溢出运算符
var willUnderflow = UInt8.min // 0
//willUnderflow = willUnderflow - 1 // run error: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
willUnderflow = willUnderflow &- 1
print(willUnderflow) // 255
