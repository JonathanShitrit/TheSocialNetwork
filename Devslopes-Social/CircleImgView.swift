//
//  CircleImgView.swift
//  Devslopes-Social
//
//  Created by Jonathan Shitrit on 1/25/17.
//  Copyright © 2017 Jonathan Shitrit. All rights reserved.
//

import UIKit

class CircleImgView: UIImageView {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize.zero
//        layer.shadowRadius = 3
//    
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
