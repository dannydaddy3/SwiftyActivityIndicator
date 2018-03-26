//
//  SwiftyActivityIndicatorConfig.swift
//  TNT-Club
//
//  Created by Danny Zorin on 14/07/2017.
//
//

import Foundation

struct SwiftyActivityIndicatorConfig {
    public static var verticalOffsetFromCenter: CGFloat = 0.0                    // default vertical offset is 0 pt
    public static var backgroundViewColor: UIColor = .black                      // default background color is black
    public static var backgroundViewSide: CGFloat = 80.0                         // default background side size is 80 pt
    public static var backgroundViewCornerRadius: CGFloat = 14                   // default corner radius is 14 pt
    public static var fadeInAnimationDuration: Double = 0.15                     // default fade in animation duration is 0.15 sec
    public static var fadeOutAnimationDuration: Double = 0.15                    // default fade out animation duration is 0.15 sec
    public static var spinnerRadius: CGFloat = 25.0                              // default spinner radius is 25 pt
    public static var spinnerColor: UIColor = .white                             // default spinner color is white
    public static var spinnerWidth: CGFloat = 2.0                                // default spinner width is 2 pt
}
