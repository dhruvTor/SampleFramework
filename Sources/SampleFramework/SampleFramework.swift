import UIKit

public class SampleFramework {
    /// Allows to convert hex to color
    /// -Warning :  The # is striped
    /// - Parameters:
    ///   - hexString: 6 digit hex string
    ///   - alpha: opacity of the color
    /// - Returns: UIColor
    internal class func colorFromHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let r, g, b: CGFloat
        let offset = hexString.hasPrefix("#") ? 1 : 0
        let start = hexString.index(hexString.startIndex, offsetBy: offset)
        let hexColor = String(hexString[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000FF) / 255
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        }
        return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
    }
    
    /// The best color
   public static var sampleColor: UIColor {
        return colorFromHexString("006736")
    }
}
