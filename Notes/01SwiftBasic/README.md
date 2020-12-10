# Swift基础


### 数据类型
1. 不推荐关键字作为标识符，非要使用的话使用``包起来。
2. 除以0.0会依据被除数正/负得到政府正/负无穷大inf，0.0/0.0得到非数nan。
3. 求余%运算结果的正负与被除数正负保持一致。
4. 移除运算符&-、&+、&*、&/、&%。
5. 区间运算符 a..<b(包括a，但不包括b)，a...b(包含a也包含b)。
6. switch语句中case可以有多个值，执行完case语句后自动终止不需要显示添加break语句，fallthrough语句贯穿可以继续判断后续case语句。

### Swift与OC混合编程
1. Swift工程中调用OC在桥接文件中引入OC头文件在Swift中直接使用就行。
2. OC工程中调用Swift在桥接文件中无需引入，在Swift提供给OC调用方法前需标识@objc，在OC文件中引入"工程名-Swift.h"(该文件是个隐藏文件，若工程名首个为数字0会将0转为_)，然后即可调用Swift方法。

### 绘制
1. 获取图形上下文UIGraphicsGetCurrentContext。
2. 绘制ctx.move,ctx.setLineWidth等。
3. 填充ctx.strokePath等。
4. 直接使用UIKit的方法进行调用绘图上下文CGContextRef时，会自动调整坐标系统；使用CoreGraphics的函数时则需要手动调整坐标系统(y坐标翻转)。
注意：绘制视图size为0或绘制范围超过视图自身size范围，则超出范围不会显示。

