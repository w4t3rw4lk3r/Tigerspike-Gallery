<p align="center">
  <img src="LOGO.png" title="HexString" float=left height="120px" width="120px">
</p>

# HexString

**Convert Hex String into UIColor**

<img src="SCREENSHOT.png" title="Screen Shot" width="240px">

## Installation

[![Platform iOS](https://img.shields.io/badge/Platform-iOS-red.svg?style=flat)](http://www.apple.com/ios)
[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift)
[![Travis-CI](https://travis-ci.org/jasonnam/HexString.svg?branch=master)](https://travis-ci.org/jasonnam/HexString)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/HexString.svg?style=flat)](https://cocoapods.org/pods/HexString)

### Carthage

```ogdl
github "jasonnam/HexString"
```

### CocoaPods

```ruby
use_frameworks!
pod 'HexString'
```

### Manual
Just copy the file 'UIColor+HexString.swift' into your project.

## Usage

### Get UIColor from Hex String

```swift
// If hex string is not valid, init with white color.
view.backgroundColor = UIColor(hexString: "#123456")
```

```swift
// This class method verifies hex string and return nil if it is not valid.
view.backgroundColor = UIColor.colorWithHexString("#123456")
```

### Get Hex String from UIColor

```swift
NSLog("\(UIColor.red.hexString ?? "ERROR")")
```

The Result will be in the form of #RRGGBB or #AARRGGBB

There is also an extension for String class.

```swift
view.backgroundColor = "#123456".toColor()
```

### Validate

FYI, above convenience init method and class method are checking if the string is hex color string, so this is not necessary if you use them.

```swift
if let hexString = UIColor.validateHexString("#123456") {
    // Do what you want
}
```

nil if the string is not a color hex string.
Return the string when it is.

## Available formats
- #RGB
- #ARGB
- #RRGGBB
- #AARRGGBB

## Contact

Any feedback and pull requests are welcome :)

Jason Nam<br>[Website](http://www.jasonnam.com)<br>[Email](mailto:contact@jasonnam.com)

## License

HexString is available under the MIT license. See the LICENSE file for more info.
