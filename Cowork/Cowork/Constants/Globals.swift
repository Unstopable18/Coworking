//
//  Globals.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation
import UIKit
class Globals{

    static func setFontTo(font:FontNamesEnum,size:CGFloat)->UIFont?{
        
        let fontV = UIFont(name: font.rawValue, size: size)
        return fontV
        
        
    }
}
