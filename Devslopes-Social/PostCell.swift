//
//  PostCell.swift
//  Devslopes-Social
//
//  Created by Jonathan Shitrit on 1/25/17.
//  Copyright © 2017 Jonathan Shitrit. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var caption: UITextView!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
