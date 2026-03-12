import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.values = [0, 20, -20, 20, -20, 15, -15, 10, -10, 5, -5, 0]
        animation.keyTimes = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1]
        animation.duration = 0.3
        self.layer.add(animation, forKey: "shake")
    }
}
