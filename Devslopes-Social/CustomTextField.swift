//
//  CustomTextField.swift
//  Devslopes-Social
//
//  Created by Jonathan Shitrit on 1/23/17.
//  Copyright © 2017 Jonathan Shitrit. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: shadowGray, green: shadowGray, blue: shadowGray, alpha: 0.3).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10.0, dy: 5.0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10.0, dy: 5.0)
    }
}
