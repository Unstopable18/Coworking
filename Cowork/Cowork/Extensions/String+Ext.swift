//
//  String+Ext.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 11/04/24.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isValidEmail = emailTest.evaluate(with: self)
        print("isValidEmail---\(isValidEmail)")
        return isValidEmail
    }

    func isPhoneNumber() -> Bool {
        let phoneNumberRegex = "^[0-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        print("isValidPhone---\(isValidPhone)")
        return isValidPhone
    }
    
    func isValidName() -> Bool {
        let nameRegex = "^[A-Z0-9a-z]{0,}[A-Z0-9a-z ]+$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidName = nameTest.evaluate(with: self)
        return isValidName
    }
}
extension NSMutableAttributedString {
    func stringUnderline(to subString: String) {
        guard let range = self.string.range(of: subString) else { return }
        let nsRange = NSRange(range, in: self.string)
        self.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
    }
    
    func stringFont(_ font: UIFont, to subString: String) {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        stringFormat(attributes, to: subString)
    }
    func stringColor(_ color: UIColor, to subString: String) {
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
            stringFormat(attributes, to: subString)
        }
    private func stringFormat(_ attributes: [NSAttributedString.Key: Any], to subString: String) {
        guard let range = self.string.range(of: subString) else { return }
        let nsRange = NSRange(range, in: self.string)
        self.addAttributes(attributes, range: nsRange)
    }
}

