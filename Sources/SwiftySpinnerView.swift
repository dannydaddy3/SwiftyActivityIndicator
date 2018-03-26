//
//  SwiftySpinnerView.swift
//  TNT-Club
//
//  Created by Danny Zorin on 14/07/2017.
//
//

import UIKit

class SwiftySpinnerView: UIView {
    private var spinnerLayer: CAShapeLayer!
    private var maskLayer: CALayer!

    var strokeThickness: CGFloat = 2.0
    var strokeColor: UIColor = .white
    var radius: CGFloat = 25

    convenience init(radius: CGFloat, strokeColor: UIColor, strokeThickness: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))

        self.strokeColor = strokeColor
        self.strokeThickness = strokeThickness
        self.radius = radius

        setup()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("SwiftySpinnerView error: consider creating this object in code")
    }

    private func setup() {
        layer.masksToBounds = true

        let arcCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let startAngle: CGFloat = CGFloat(Float.pi * 3 / 2)
        let endAngle: CGFloat = CGFloat(Float.pi / 2 + Float.pi * 5)
        let spinnerPath = UIBezierPath(arcCenter: arcCenter, radius: bounds.width / 2 - strokeThickness, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        spinnerLayer = CAShapeLayer()
        spinnerLayer.contentsScale = UIScreen.main.scale
        spinnerLayer.frame = CGRect(x: 0, y: 0, width: arcCenter.x * 2, height: arcCenter.y * 2)
        spinnerLayer.fillColor = UIColor.clear.cgColor
        spinnerLayer.strokeColor = strokeColor.cgColor
        spinnerLayer.lineWidth = strokeThickness
        spinnerLayer.lineCap = kCALineCapRound
        spinnerLayer.lineJoin = kCALineJoinBevel
        spinnerLayer.path = spinnerPath.cgPath

        maskLayer = CALayer()
        maskLayer.contents = #imageLiteral(resourceName: "angle-mask").cgImage
        maskLayer.frame = spinnerLayer.bounds
        spinnerLayer.mask = maskLayer

        layer.addSublayer(spinnerLayer)
    }

    func startAnimating() {
        animate()
    }

    func stopAnimating() {
        maskLayer.removeAllAnimations()
        spinnerLayer.removeAllAnimations()
    }

    private func animate() {
        let animationDuration: Double = 1
        let linearCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Float.pi * 2
        animation.duration = animationDuration
        animation.timingFunction = linearCurve
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = false
        maskLayer.add(animation, forKey: "rotate")

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration
        animationGroup.repeatCount = Float.greatestFiniteMagnitude
        animationGroup.isRemovedOnCompletion = false
        animationGroup.timingFunction = linearCurve

        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0.015
        strokeStartAnimation.toValue = 0.515

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.485
        strokeEndAnimation.toValue = 0.985

        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        spinnerLayer.add(animationGroup, forKey: "progress")
    }
}
