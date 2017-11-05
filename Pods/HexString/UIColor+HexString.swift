//
// UIColor+HexString.swift
// HexString
//
// Copyright (c) 2015-2016 Jason Nam (http://www.jasonnam.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

public extension String {
    /// Converts hex color value string to UIColor.
    /// The string has to be a hex color value string in forms of #RGB, #ARGB, #RRGGBB and #AARRGGBB.
    public func toColor() -> UIColor? {
        return UIColor.colorWithHexString(self)
    }

    fileprivate var RGBColor: UIColor {
        let red = getHexValue(from: self, start: 0, length: 1)
        let green = getHexValue(from: self, start: 1, length: 1)
        let blue = getHexValue(from: self, start: 2, length: 1)

        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1.0)
    }

    fileprivate var ARGBColor: UIColor {
        let alpha = getHexValue(from: self, start: 0, length: 1)
        let red = getHexValue(from: self, start: 1, length: 1)
        let green = getHexValue(from: self, start: 2, length: 1)
        let blue = getHexValue(from: self, start: 3, length: 1)

        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha)/255)
    }

    fileprivate var RRGGBBColor: UIColor {
        let red = getHexValue(from: self, start: 0, length: 2)
        let green = getHexValue(from: self, start: 2, length: 2)
        let blue = getHexValue(from: self, start: 4, length: 2)

        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1.0)
    }

    fileprivate var AARRGGBBColor: UIColor {
        let alpha = getHexValue(from: self, start: 0, length: 2)
        let red = getHexValue(from: self, start: 2, length: 2)
        let green = getHexValue(from: self, start: 4, length: 2)
        let blue = getHexValue(from: self, start: 6, length: 2)

        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha)/255)
    }

    fileprivate func getHexValue(from hexString: String, start: Int, length: Int) -> CUnsignedInt {
        var result: CUnsignedInt = 0
        let colorValue = (self as NSString).substring(with: NSMakeRange(start, length))

        let scanner = Scanner(string: Array(colorValue.characters).count == 2 ? colorValue  : "\(colorValue)\(colorValue)")
        scanner.scanHexInt32(&result)

        return result
    }
}

public extension UIColor {
    /// Initializes with a hex color value string.
    /// If the conversion fails, the initialized object will have white color value.
    public convenience init(hexString: String) {
        var red: CGFloat = 1.0
        var green: CGFloat = 1.0
        var blue: CGFloat = 1.0
        var alpha: CGFloat = 1.0

        if let color = UIColor.colorWithHexString(hexString) {
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

    /// Converts UIColor to hex color value string.
    public var hexString: String? {
        guard let colorModel = cgColor.colorSpace?.model, let components = cgColor.components else {
            return nil
        }

        var red = 0
        var green = 0
        var blue = 0
        var alpha = 0

        if colorModel.rawValue == CGColorSpaceModel.monochrome.rawValue {
            red = lroundf(Float(components[0]) * 255)
            green = lroundf(Float(components[0]) * 255)
            blue = lroundf(Float(components[0]) * 255)
            alpha = lroundf(Float(components[1]) * 255)
        } else if colorModel.rawValue == CGColorSpaceModel.rgb.rawValue {
            red = lroundf(Float(components[0]) * 255)
            green = lroundf(Float(components[1]) * 255)
            blue = lroundf(Float(components[2]) * 255)
            alpha = lroundf(Float(components[3]) * 255)
        }

        if alpha == 255 {
            return String(format: "#%02lX%02lX%02lX", red, green, blue)
        } else if alpha < 255 {
            return String(format: "#%02lX%02lX%02lX%02lX", alpha, red, green, blue)
        } else {
            return nil
        }
    }

    /// Returns UIColor object for the hex color value string.
    /// - Parameter hexString: hex color value string to be converted.
    /// - Returns: Converted UIColor object. nil if the conversion fails.
    public class func colorWithHexString(_ hexString: String) -> UIColor? {
        if let colorString = validateHexString(hexString) {
            let count = Array(colorString.characters).count

            switch count {
            case 3:
                return colorString.RGBColor
            case 4:
                return colorString.ARGBColor
            case 6:
                return colorString.RRGGBBColor
            case 8:
                return colorString.AARRGGBBColor
            default:
                return nil
            }
        } else {
            return nil
        }
    }

    /// Validates a string if it is a hex color value in forms of #RGB, #ARGB, #RRGGBB and #AARRGGBB.
    public class func validateHexString(_ hexString: String) -> String? {
        guard hexString != "" else {
            return nil
        }

        guard hexString.characters.first == "#" else {
            return nil
        }

        let length = hexString.characters.count
        guard length == 4 || length == 5 || length == 7 || length == 9 else {
            return nil
        }

        let colorString = hexString.replacingOccurrences(of: "#", with: "").uppercased()

        let disallowedCharacters = CharacterSet(charactersIn: "0123456789ABCDEF").inverted
        guard (colorString as NSString).rangeOfCharacter(from: disallowedCharacters).location == NSNotFound else {
            return nil
        }

        return colorString
    }
}
