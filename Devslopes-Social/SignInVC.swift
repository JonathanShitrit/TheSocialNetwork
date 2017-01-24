//
//  ViewController.swift
//  Devslopes-Social
//
//  Created by Jonathan Shitrit on 1/19/17.
//  Copyright © 2017 Jonathan Shitrit. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Firebase

class SignInVC: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func facebookButton(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        print("LOGIN MANAGER: \(loginManager)")
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            print("JON: LOGIN RESULT! \(loginResult)")
            switch loginResult {
            case .failed(let error):
                print("JON: FACEBOOK LOGIN FAILED: \(error)")
            case .cancelled:
                print("JON: User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("JON: Logged in!")
                print("JON: GRANTED PERMISSIONS: \(grantedPermissions)")
                print("JON: DECLINED PERMISSIONS: \(declinedPermissions)")
                print("JON: ACCESS TOKEN \(accessToken)")
                
                let refreshedToken = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                
                print("InstanceID token: \(refreshedToken)")
                    
                self.firebaseAuth(refreshedToken)
                
               
            }
        }
    }
    

//        let facebookLogin = FBSDKLoginManager()
//        
//        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
//            if error != nil {
//                print("JON: Unable to authenticate with Facebook - \(error)")
//            } else if (result?.isCancelled == true) {
//                print("JON: User cancelled Facebook authentication")
//            } else {
//                print("JON: User successfully authenticated with Facebook")
//                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//                
//                self.firebaseAuth(credential)
//            }
//        }
//    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if (error != nil) {
                print("JON: Unable to authenticate with Firebase - \(error)")
            } else {
                print("JON: User successfully authenticated with Firebase")
            }
        })
    }
    

}

