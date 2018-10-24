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
    

    @IBOutlet weak var scView: UIScrollView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var password: CustomTextField!
    @IBOutlet weak var btnFBLogin: FBSDKLoginButton!
    @IBOutlet weak var username: CustomTextField!
    
    var activeField: UITextField!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
        setupLayout()
        observeKeyboardNotifications()
//        btnFBLogin.delegate = self
//
//        btnFBLogin.readPermissions = ["public_profile", "email"]
    }
    
    fileprivate func observeKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @objc func keyboardWillShow(notification: Notification){
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: targetFrame.height, right: 0.0)
        scView.contentInset = contentInsets
        scView.scrollIndicatorInsets = contentInsets
        
        var aRect = self.view.frame
        aRect.size.height -= targetFrame.height
        if (activeField != nil && !aRect.contains(activeField.frame.origin)) {
            scView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    //Not testable
    
    @objc func keyboardWillHide(notif: Notification){
        let contentInsets = NSCoder.uiEdgeInsets(for: "")
        scView.contentInset = contentInsets
        scView.scrollIndicatorInsets = contentInsets
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? FeedViewController else {return}
        
        dest.user = user ?? nil
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
        if !RegisterManager.checkTextFieldIsEmpty(textFields: [self.password, self.username]) {
            guard let username = self.username.text, let password = self.password.text else {
                let alert = UIAlertController(title: "Fill all fields", message: nil, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
            let result = LoginManager.isValid(email: username, password: password)
            if result.success{
                user = result.object as? User
                self.performSegue(withIdentifier: "goTo", sender: nil)
            }else{
                let alert = UIAlertController(title: "Incorrect username or password", message: nil, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true, completion: nil)
                }
            }
            
        }else{
            let alert = UIAlertController(title: "Fill all fields", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
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


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
