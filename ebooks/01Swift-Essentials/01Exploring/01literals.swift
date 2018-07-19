// #!/usr/bin/swift

// Number iterals
let num = 8979_212_90_9212
print(num)                              // 8979212909212: Underscores have no effect on value
print(0b1010011)                        // 83 decimal: binary values begin 0b
print(0o123)                            // 83 decimal: octal values begin 0o
print(0123)                             // 123 decimal: leading zeros decimal
print(0x7b)                             // 123 decimal: hex values begin 0x
print(299.792458e6)                     // 299792458.0 as a Double: e6 is *10^6
print(299.792_458_e6)                   // 299792458.0: underscores can be used
print(0x4p10)                           // 4096.0 as a Double: p10 is *2^10
print(1e-1)                             // 0.1  as a Double: e-1 is *10^-1
print(1e-2)                             // 0.01 as a Double: e-2 is *10^-2
print(0x1p-1)                           // 0.5  as a Double: p0-1 is *2^-1
print(0x1p-2)                           // 0.25  as a Double: p0-2 is *2^-2
print(0xAp-1)                           // 5.0   as a Double: p0-1 is *2^-1


// String literals
print("3+4 is \(3+4)")                 // 3+4 is 7

//  += is an array append operator
var shopping = [ "Milk", "Eggs", "Coffee", ]
shopping += [ "Tea" ]
shopping += [ "Apple" ]
print(shopping)                        // [ "Milk", "Eggs", "Coffee", "Tea", "Apple

// Nil coalescing operator
var canBeNil:Int? = 1
print(canBeNil ?? 2)                          // 1
print(nil ?? 2)                        // 2

// switch
var position = 11
switch position {                       // switch can be any expression
  case 1: print("1st")                  // case statements do not fall through
  case 2: print("2nd")                  // each is independent
  case 3: print("3rd")
  case 4...20:                          // ranges can be used as a match
     print("\(position)th")             // prints if >= 4 and <= 20
  case position where (position % 10) == 1: // as can where clauses
     print("\(position)st")
  case let p where (p % 10) == 2:       // also can use local constants
     print("\(p)nd")
  case let p where (p % 10) == 3:
     print("\(p)rd")
  default: print("\(position)th")       // default for catch-all case
}
// 11th

// ~= pattern match operator. it's a way of asking whether a pattern matches a particular value
print(4...10 ~= 4)      // true
// print(4 ~= 4...8)    // error
print(1..<10 ~= 10)     // false
