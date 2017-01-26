//
//  CustomView.swift
//  Devslopes-Social
//
//  Created by Jonathan Shitrit on 1/23/17.
//  Copyright © 2017 Jonathan Shitrit. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        layer.cornerRadius = 2.0
    }

}
