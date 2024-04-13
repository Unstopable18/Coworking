//
//  UIButton+Ext.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 11/04/24.
//

import Foundation
import UIKit

extension UIButton {
    func setAttributedTextWithAttributes(text: String, font: UIFont, color: UIColor, underlineText: String) {
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.stringUnderline(to: underlineText)
        
        attributedString.stringColor(color, to: underlineText)

        attributedString.stringFont(font, to: text)
        
        setAttributedTitle(attributedString, for: .normal)
    }
}
