// #!/usr/bin/swift

var shopping = [ "Milk", "Eggs", "Coffee", "Tea", ]
var costs = [ "Milk": 1, "Eggs": 2, "Coffee": 3, "Tea": 4, ]

func costOf(items: [String], costs:[String: Int]) -> Int {
  var cost = 0
  for item in items {
    if let cm = costs[item] {
      cost += cm
    }
  }
  return cost
}
let cost1 = costOf(items: shopping, costs: costs)
print("cost1 is \(cost1)")  // 10

// named arguments 
func costOfNamed(basket items: [String], prices costs:[String: Int]) -> Int {
  var cost = 0
  for item in items {
    if let cm = costs[item] {
      cost += cm
    }
  }
  return cost
}
let cost2 = costOfNamed(basket: shopping, prices: costs)
print("cost2 is \(cost2)")  // 10

// Optional arguments and default values
func costOfDefault(items: [String], costs:[String: Int] = costs) -> Int {
  var cost = 0
  for item in items {
    if let cm = costs[item] {
      cost += cm
    }
  }
  return cost
}
let cost3 = costOfDefault(items: shopping)
print("cost3 is \(cost3)")  // 10

// Anonymous arguments
func costOfAnonymous(_ items: [String], _ costs:[String: Int]) -> Int {
  var cost = 0
  for item in items {
    if let cm = costs[item] {
      cost += cm
    }
  }
  return cost
}
let cost4 = costOfAnonymous(shopping, costs)
print("cost4 is \(cost4)")  // 10


// Multiple return values and variadic arguments
func minMaxTuple(numbers: Int...) -> (min: Int, max: Int)? {
  if (numbers.count == 0) {
    return nil
  }
  var min = Int.max
  var max = Int.min
  for number in numbers {
    if number < min {
      min = number
    }
    if number > max {
      max = number
    }
  }
  return (min: min, max: max)
}
var minmax = minMaxTuple()
if (minmax == nil) {
  print("you have not pass parameter!")
} else {
  print("minmax")
}
var minmax2 = minMaxTuple(numbers: 1, 2, 5, 8, 10, 89, 11)
if (minmax2 != nil) {
  print("min is \(minmax2!.min), max is \(minmax2!.max)") // min is 1, max is 89
  print("min is \(minmax2!.0), max is \(minmax2!.1)") // min is 1, max is 89
}


// struct. In essence, tuples with named values are anonymous structures.
// When a structure is initialized, all the fields must be assigned. 
// They can be passed in as named arguments in the initializer, or specified in the structure definition
struct MinMax {
  var min: Int
  var max: Int
}
func minMaxStruct(numbers: Int...) -> MinMax? {
  if numbers.count == 0 {
    return nil
  }
  var minmax = MinMax(min: Int.max, max: Int.min)
  for number in numbers {
    if number < minmax.min {
      minmax.min = number
    }
    if number > minmax.max {
      minmax.max = number
    }
  }
  return minmax
}
var minmax3 = minMaxStruct()
if (minmax3 == nil) {
  print("you have not pass parameter")
}
var minmax4 = minMaxStruct(numbers: -11, 1, 4, 9, 100)
if (minmax4 != nil) {
  print("min is \(minmax4!.min) and max is \(minmax4!.max)") // min is -11 and max is 100
}


// throws
struct Oops: Error {
  let message: String
}
func cardName(_ value: Int) throws -> String {
  guard value >= 1 && value <= 13 else {
    throw Oops(message: "Unknown card")
  }
  let names = [11: "Jack", 12: "Queen", 13: "King", 1: "Ace"]
  return names[value] ?? "\(value)"
}
do {
  let ace = try cardName(1)
  print("card 1: \(ace)")
  let isNil = try? cardName(15)
  if isNil == nil {
    print("card 15 return nil") 
  }
  if let king = try? cardName(13) {
    print("card 13: \(king)")
  }
  let unknown = try cardName(15)
  print("card 15: \(unknown)")
} catch {
  print("exception: \(error)")
}


// defer
func deferExample() {
  defer {                               // executed at function return
    print("C")
  }
  defer {
    print("E")
  }
  print("A")
  defer {
    print("B")
  }
  defer {
    print("D")
  }
}
deferExample()                          // prints A, D, B, E, C

func deferEarly() {
  defer {
    print("C")
  }
  defer {
    print("D")
  }
  print("A")
  defer {
    print("E")
  }
  return
  defer {                               // generates an unreachable warning
    print("B")
  }
}
deferEarly()                            // prints A, E, D, C
