import UIKit

extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(Float(red) / 255.0),
                  green: CGFloat(Float(green) / 255.0),
                  blue: CGFloat(Float(blue) / 255.0),
                  alpha: CGFloat(1.0))
    }
}
