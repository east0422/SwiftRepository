import Foundation

let args = CommandLine.arguments[1..<CommandLine.arguments.count]
for arg in args {
  print("\(arg.uppercased())")
}
exit(0)
