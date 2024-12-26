//
//  AccentGradient.swift
//  ExpenseMe
//
//  Created by Ashish on 22/12/24.
//

import UIKit

class AccentGradient: UIView {

    override func draw(_ rect: CGRect) {
        let height=rect.height
        let width=rect.width
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors=[UIColor.systemRed.cgColor,UIColor.systemBlue.cgColor]
        gradientLayer.frame = rect
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    }

}
