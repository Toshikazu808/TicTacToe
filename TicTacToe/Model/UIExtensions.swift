//
//  UIExtensions.swift
//  TicTacToe
//
//  Created by Ryan Kanno on 5/30/20.
//  Copyright © 2020 Ryan Kanno. All rights reserved.
//

import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 1
        pulse.toValue = 1.2
        pulse.autoreverses = true
        pulse.repeatCount = 0
        pulse.initialVelocity = 3
        pulse.damping = 1
        layer.add(pulse, forKey: nil)
    }
}

extension UIImageView {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 1
        pulse.toValue = 1.2
        pulse.autoreverses = true
        pulse.repeatCount = 0
        pulse.initialVelocity = 3
        pulse.damping = 1
        layer.add(pulse, forKey: nil)
    }
}
