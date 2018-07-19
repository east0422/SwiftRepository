# Exploring Swift
macOS High Sierra(10.13.6), XCode9.4.1, swift(4.1.2)。
```
// method1: using the xcrun swift or swift command in terminal.
swift / xcrun swift

// method2: you can create hello.swift and swift hello.swift path in terminal
swift /Users/NewAdmin/Desktop/hello.swift

// method3: you can create hello.swift and execute it
#!/usr/bin/swift
print("Hello World!")
// in terminal
chmod 777 hello.swift or chmod a+x hello.swift
./hello.swift // print "Hello World!" in console

// method4: sublimeText swift plugin
// 1. install swift plugin
// 2. create swift.sublime-build
	{
	  "shell_cmd": "swift $file",
	  "path": "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/",
	  "selector": "source.swift"
	}
// 3. create hello.swift
	#!/usr/bin/swift // can delete
	print("hello world")
// 4. select build system swift and ctrl + b
	"hello world" in console
```

## 1. REPL
* Xcode 6.1 introduces yet another way to experiment with Swift in the form of an interactive Read Eval Print Loop, or REPL. Developers familiar with interpreted languages will feel comfortable in this command-line environment, and even experienced developers will find a few unique features。
* All you need to do is type Swift statements and the REPL will immediately execute your code. Expression results are automatically formatted and displayed along with their type, as are the results of both variable and constant declarations。

## 2. literals
* Numbers can include underscores to provide better readability; so 68_040_111 is the same as 68040111。
* AeB means A*10^B and 0xApB means A*2^B。
* An interpolated string has an embedded expression which is evaluated, converted into a string, and concatenated into the result("3+4=\(3+4)" => 3+4=7)。
* ~= pattern match operator(eg 1...5 ~= 4 => true)。
* switch no need break。

## 3. Iterate arrays, dictionaries and sequences
* for _ in 1...5, _ can be used as a hole to act as a throwaway value, but not read。and not need wrap with parentheses(eg (for _ in 1...3) will error)。
* Apple recommends the use of ++i instead of i++ (and conversely, --i instead of i--) because they will return the result of i after the operation, which may be the expected value。

## 4. Functions
* named arguments。
* optional arguments and default values。
* anonymous arguments。
* Multiple return values and variadic arguments。
* tuple optional(eg: (Int, Int)?)。
* do try catch and Error。

## 5. Compiling and running swift from the command line
* time swift hello.swift(time command can be give the running time of the interpreted and compiled)。
* swiftc -o hello hello.swift(compile, also can be used to link together many individual Swift files into one executable)。
* time ./hello(run hello and give the time)。

