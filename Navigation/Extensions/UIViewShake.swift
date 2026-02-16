import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.values = [0, 10, -10, -10, 10, -5, 5, 0]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.625, 0.75, 0.875, 1]
        animation.duration = 0.4
        self.layer.add(animation, forKey: "shake")
    }
}
