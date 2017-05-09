//
//  UIView+Additions.swift
//  WeatherInfo
//
//  Created by vishalsonawane on 09/05/17.
//  Copyright © 2017 vishalsonawane. All rights reserved.
//

import UIKit

extension UIView{
    
    func setRoundedCorners(cornerRadius:CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.clipsToBounds = true
    }
}
extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

