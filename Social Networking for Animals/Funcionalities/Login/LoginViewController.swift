//
//  LoginViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 17/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    

    @IBOutlet weak var btnFBLogin: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnFBLogin.delegate = self
        
        btnFBLogin.readPermissions = ["public_profile", "email"]
        

        // Do any additional setup after loading the view.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.localizedDescription)
        }else if result.isCancelled {
            print("canceled")
        }else{
            print("logei *_*")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
