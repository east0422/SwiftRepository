# Creating an iOS swift app
macOS High Sierra(10.13.6), XCode9.4.1, swift(4.1.2)。

* An iOS application is a compiled executable, along with a set of supporting files in a bundle. The application bundle is packaged into an archive file for installing onto a device or uploading to the App Store。

## 1. XCTest
* XCTest framework has a base class called XCTestCase that all tests inherit from。
* Methods beginning with test and no arguments。
* Hello Class must added to the test target too, but HelloTest class should never added to the main target。

## 2. Protocols 
* Has method signatures but no method implementations。
* Classes can implement zero or more protocols。
* Protocol might have a number of methods that are either required (the default) or optional。 
* Optional protocol methods are only supported when the protocol is marked with the @objc attribute. This declares that the class will be backed by an NSObject class for interoperability with Objective-C. Pure Swift protocols cannot have optional methods。
* When a class has both a superclass and one or more protocols, the superclass should be listed first。

## 3. Enums
* An enum is a closed set of values。
* Unlike C, enumerated values do not have a specific type by default, so they cannot be converted to and from an integer value。


