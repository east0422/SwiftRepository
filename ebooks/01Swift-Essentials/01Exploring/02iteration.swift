// #!/usr/bin/swift

/** 
  Both Array and Dictionary conform to the SequenceType protocol, which allows them to be iterated with 
  a for...in loop. Collections (as well as other objects such as Range) that implement SequenceType have
  a generate method, which returns a GeneratorType that allows the data to be iterated over. It is possible 
  or custom Swift objects to implement SequenceType to allow them to be used in a for...in loop.
*/

// for in
for i in 1...5 {
  print("i is \(i)")
}
for _ in 1...5 { // _ can be used as a hole to act as a throwaway value, but not read
  print("looping")
}

// the order of keys in a dictionary are not guaranteed
var costs = ["Milk":1, "Eggs":2, "Coffee":3, "Tea":4,]
print(costs.keys) // ["Eggs", "Coffee", "Tea", "Milk"]
print(costs.values) // [2, 3, 4, 1]
// iterate over key/values together
for (item, cost) in costs {
  print("The \(item) costs \(cost)")
}

// tuple
var (x, y) = (10, 20)
print(x)  // 10
print(y)  // 20

// break and continue
var deck = [1...13, 1...13, 1...13, 1...13]
suits: for suit in deck {               // suit: introduces a label at this for block
  print("suit \(suit) ---------")
  for card in suit {                    // nested for block
    print("card \(card)")
    if card == 3 {
      continue                          // goes to 'for card in suit' with next card
    }
    print("card != 3")
    if card == 5 {
      continue suits                    // goes to the 'for suit in deck' with next suit
    }
    print("card != 5")
    if card == 7 {
      break                             // leaves 'for card in suit' block
    }
    print("card != 7")
    if card == 13 {
      break suits                       // leaves 'for suit in deck' block
    }
  }
}
