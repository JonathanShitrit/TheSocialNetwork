//
//  AlertExtension.swift
//  Devslopes-Social
//
//  Created by Jonathan Shitrit on 1/24/17.
//  Copyright © 2017 Jonathan Shitrit. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func displayAlert(title: String, message: String, fromController controller: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        //use controller.present because trying to show alert when it isnt the main controller hierarchy wont work
        controller.present(alert, animated: true, completion: nil)
    }
}
