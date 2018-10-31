//
//  RegisterAccountViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 23/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class RegisterAccountViewController: UIViewController {
    

      @IBOutlet weak var btnFBLogin: FBSDKLoginButton!
    @IBOutlet weak var password: DesignableUITextField!
    @IBOutlet weak var username: DesignableUITextField!
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var invalidEmail: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scView: UIScrollView!
    @IBOutlet weak var singupButton: UIButton!
    var activeField: UITextField!
    var imagePicker = UIImagePickerController()
    var tapGestureRecognizer: UITapGestureRecognizer? = nil
    var pickedImageName: String?
    var newUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidEmail.isHidden = true
        username.delegate = self
        password.delegate = self
        email.delegate = self
        setupLayout()
        observeKeyboardNotifications()
        imagePicker.delegate = self
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        image.addGestureRecognizer(tapGestureRecognizer!)
         btnFBLogin.readPermissions = ["public_profile", "email"]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //setupLayout()
        singupButton.layer.cornerRadius = 22
    }
    

    fileprivate func observeKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupLayout(){
        singupButton.clipsToBounds = true
        singupButton.layer.cornerRadius = 22
        btnFBLogin.clipsToBounds = true
        btnFBLogin.layer.cornerRadius = 22
        
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let dest = segue.destination as? FeedViewController else {return}
//        dest.user = newUser
//    }
    
    @objc func keyboardWillHide(notif: Notification){
        let contentInsets = NSCoder.uiEdgeInsets(for: "")
        scView.contentInset = contentInsets
        scView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func singup(_ sender: Any) {
        let alertCompleteFields = UIAlertController(title: "Complete all the fields", message: nil, preferredStyle: .alert)
        let alertInvalidUsername = UIAlertController(title: "Please, chose another username", message: nil, preferredStyle: .alert)
        if(RegisterManager.checkTextFieldIsEmpty(textFields: [self.password, self.email, self.username])){
            
            DispatchQueue.main.async {
                self.present(alertCompleteFields, animated: true, completion: nil)
            }
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alertCompleteFields.dismiss(animated: true, completion: nil)
            }
        }else{
            guard let email = self.email.text, let password = self.password.text,let username = self.username.text else {
                DispatchQueue.main.async {
                    self.present(alertCompleteFields, animated: true, completion: nil)
                }
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                    alertCompleteFields.dismiss(animated: true, completion: nil)
                }
                return
            }
            if RegisterManager.validateRegister(username: username) {
                RegisterManager.validateEmail(email:email) { (error, isValid, suggestionEmail) in
                    if !(error == nil){
                        return
                    }
                    if isValid {
                         DispatchQueue.main.async {
                            self.invalidEmail.isHidden = true
                            self.image.accessibilityIdentifier = self.pickedImageName
                            self.newUser = RegisterManager.saveNewUser(username: username, password: password, email: email, photo: self.image.image)
                        }
                        self.performSegue(withIdentifier: "registerTo", sender: nil)
                        
                    }else{
                        DispatchQueue.main.async {
                            self.invalidEmail.isHidden = false
                            self.invalidEmail.shake()
                        }
                    }
                }
                    
            }else{
                DispatchQueue.main.async {
                    self.present(alertInvalidUsername, animated: true, completion: nil)
                }
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    alertInvalidUsername.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        _ = tapGestureRecognizer.view as! UIImageView
        
        let actionSheet: UIAlertController = UIAlertController(title: "Capture an image", message: "Choose an option", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default)
        { _ in
            guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) else {
                let alert: UIAlertController = UIAlertController(title: "Oops...", message: "Camera is not available", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            self.imagePicker.sourceType = .camera
            
            DispatchQueue.main.async {
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let galeriaAction = UIAlertAction(title: "Library", style: .default)
        { _ in
            self.imagePicker.sourceType = .photoLibrary
            
            DispatchQueue.main.async {
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(galeriaAction)
        
        DispatchQueue.main.async {
            self.present(actionSheet, animated: true, completion: nil)
        }
        
    }
    
}

extension RegisterAccountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension RegisterAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.image.image = imagePicked
                self.image.clipsToBounds = true
                self.image.layer.cornerRadius = self.image.frame.width/2
                //self.image.bounds = self.viewImage.bounds
                self.image.contentMode = .scaleAspectFill
            }
            self.pickedImageName = "Petgram\(imagePicked.hashValue)"
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

