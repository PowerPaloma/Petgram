//
//  LoginViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 17/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    

    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var password: CustomTextField!
    @IBOutlet weak var btnFBLogin: FBSDKLoginButton!
    @IBOutlet weak var username: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
//        btnFBLogin.delegate = self
//
//        btnFBLogin.readPermissions = ["public_profile", "email"]
    }
    
    func setupLayout(){
        getStartedButton.clipsToBounds = true
        getStartedButton.layer.cornerRadius = 22
        username.roundCorners(corners: .allCorners, radius: 15)
        password.roundCorners(corners: .allCorners, radius: 15)
        password.image = UIImage(named: "pass")
        username.image = UIImage(named: "user")
        password.setupImageView()
        username.setupImageView()
        
    }
    
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        if error != nil {
//            print(error.localizedDescription)
//        }else if result.isCancelled {
//            print("canceled")
//        }else{
//            print("logei *_*")
//        }
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//        print("logout")
//    }
//

    @IBAction func getStarted(_ sender: Any) {
        
        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
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
