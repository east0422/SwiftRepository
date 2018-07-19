# Parsing network data
macOS High Sierra(10.13.6), XCode9.4.1, swift(4.1.2)。

## 1. Loading data from URLs
* HTTP(or HTTPS) URL is the most common way to load data from a remote network source. URLs can be manipulated with the NSURL class。
* URLSession is typically used to perform operations with URLs, and individual sessions can be created through the initializer or the standard shared session can be used。
* use a switch statement with where clauses can be used to test multiple different conditions and also show which part of the condition is being tested. Although a switch statement requires a single expression, it is possible to use a tuple to group multiple values into a single expression. Using a tuple is that it permits the cases to be matched on types。
* @escaping. A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape. Marking a closure with @escaping means you have to refer to self explicitly within the closure。
* Swift has a special syntax to deal with functions that take blocks; the block can be promoted out of the function's argument and left as a trailing argument. This is known as a trailing closure. This can be used for any function whose final argument is a function。

## 2. Parsing JSON
* JSON stands for JavaScript Object Notation, can store simple numeric, logical, and string-based types along with the array and dictionary representations.
* JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? Array<Dictionary<String, String>>。

## 3. Parsing XML 
* XMLParser is a stream-oriented parser; that is, it reports individual elements as they are seen. The parser calls the delegate to notify when the elements are seen and have finished. When an element is seen, the parser also includes any attributes that were present。
* didStartElement set flag to true, foundCharacters set string to variable, didEndElement reset flag to false and handle variable。

