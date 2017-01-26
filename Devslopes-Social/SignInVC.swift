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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: CustomTextField!

    @IBOutlet weak var passwordTexField: CustomTextField!
    

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "GoToFeed", sender: nil)
        }
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

    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if (error != nil) {
                print("JON: Unable to authenticate with Firebase - \(error)")
            } else {
                print("JON: User successfully authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        })
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTexField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("JON: \(email) signed in successfully")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            //Shows incorrect email or password alert
                            let alert = UIAlertController()
                            alert.displayAlert(title: "Unable to authenticate", message: "Email or password is incorrect. Please try again.", fromController: self)

                            print("JON: Unable to create user with email and password")
                        }
                        else {
                            print("JON: Successfully created user")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "GoToFeed", sender: nil)
    }

}

