//
//  PulseAnimation.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/18.
//

import UIKit

class PulseAnimation: CALayer {

    var animationGroup = CAAnimationGroup()
    var animationDuration: TimeInterval = 0.9
    var radius: CGFloat = 200
    var numberOfPulses: Float = 10

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(numberOfPulses: Float = 10, radius: CGFloat, position: CGPoint) {
        super.init()
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position

        self.bounds = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
        self.cornerRadius = radius

        DispatchQueue.global(qos: .default).async {
            self.setUpAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }

    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: 0)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration

        return scaleAnimation
    }

    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = 10
        opacityAnimation.keyTimes = [0, 0, 0]
        opacityAnimation.values = [0, 0, 0]
        return opacityAnimation
    }

    func setUpAnimationGroup() {
        self.animationGroup.duration = animationDuration
        self.animationGroup.repeatCount = numberOfPulses

        let defaultCurve = CAMediaTimingFunction(name: .default)
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations = [scaleAnimation(), createOpacityAnimation()]



    }
}
