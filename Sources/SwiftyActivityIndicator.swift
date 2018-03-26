//
//  SwiftyActivityIndicator.swift
//  TNT-Club
//
//  Created by Danny Zorin on 14/07/2017.
//
//

import UIKit

class SwiftyActivityIndicator: UIView {

    // MARK: - Private properties

    private var backgroundView: UIView!
    private var spinnerView: SwiftySpinnerView!

    // MARK: - Initializers

    convenience init(inside view: UIView) {
        self.init(frame: .zero)
        view.addSubview(self)

        setup()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("SwiftyActivityIndicator error: consider creating this object in code")
    }

    private func setup() {
        isUserInteractionEnabled = false

        backgroundView = UIView()
        backgroundView.backgroundColor = SwiftyActivityIndicatorConfig.backgroundViewColor
        backgroundView.layer.cornerRadius = SwiftyActivityIndicatorConfig.backgroundViewCornerRadius
        backgroundView.alpha = 0.0
        addSubview(backgroundView)

        spinnerView = SwiftySpinnerView(radius: SwiftyActivityIndicatorConfig.spinnerRadius,
                                        strokeColor: SwiftyActivityIndicatorConfig.spinnerColor,
                                        strokeThickness: SwiftyActivityIndicatorConfig.spinnerWidth)
        backgroundView.addSubview(spinnerView)

        layoutViews()
    }

    private func layoutViews() {
        if let containerView = superview {
            let indicatorSide: CGFloat = SwiftyActivityIndicatorConfig.backgroundViewSide
            let verticalOffset = SwiftyActivityIndicatorConfig.verticalOffsetFromCenter

            let xOrigin: CGFloat = (containerView.frame.width / 2.0) - (indicatorSide / 2.0)
            let yOrigin: CGFloat = (containerView.frame.height / 2.0) - (indicatorSide / 2.0) + verticalOffset
            frame = CGRect(x: xOrigin, y: yOrigin, width: indicatorSide, height: indicatorSide)

            backgroundView.frame = bounds

            let spinnerViewSide: CGFloat = SwiftyActivityIndicatorConfig.spinnerRadius * 2
            let xOrigin1: CGFloat = (backgroundView.frame.width / 2.0) - (spinnerViewSide / 2.0)
            let yOrigin1: CGFloat = (backgroundView.frame.height / 2.0) - (spinnerViewSide / 2.0)
            spinnerView.frame = CGRect(x: xOrigin1, y: yOrigin1, width: spinnerViewSide, height: spinnerViewSide)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutViews()
    }

    // MARK: - Public methods for show/dismiss

    func show() {
        superview?.isUserInteractionEnabled = false
        superview?.bringSubview(toFront: self)
        spinnerView.startAnimating()
        UIView.animate(withDuration: SwiftyActivityIndicatorConfig.fadeInAnimationDuration,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseIn, .beginFromCurrentState],
                       animations: {
                        self.backgroundView.alpha = 1.0
        }, completion: nil)
    }

    func dismiss() {
        superview?.isUserInteractionEnabled = true
        superview?.sendSubview(toBack: self)
        UIView.animate(withDuration: SwiftyActivityIndicatorConfig.fadeInAnimationDuration,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseOut, .beginFromCurrentState],
                       animations: {
                        self.backgroundView.alpha = 0.0
        }, completion: { _ in
            self.spinnerView.stopAnimating()
        })
    }
}
