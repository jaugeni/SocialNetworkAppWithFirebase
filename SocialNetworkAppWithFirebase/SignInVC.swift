//
//  SignInVC.swift
//  SocialNetworkAppWithFirebase
//
//  Created by YAUHENI IVANIUK on 1/18/17.
//  Copyright © 2017 YauheniIvaniuk. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("YI: Unable to authecate with Facebook -\(error)")
            } else if result?.isCancelled == true {
                print("YI: User cancelled Facebook authentication")
            } else {
                print("YI: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
            
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("YI: Unable to authenticate with Firebase - \(error)")
            } else {
            print("YI: Successfully authenticated with Firebase")
            }
        })
    }

}

