//
//  RegisterAccountViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 23/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class RegisterAccountViewController: UIViewController {
    
    @IBOutlet weak var invalidEmail: UILabel!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scView: UIScrollView!
    @IBOutlet weak var password: CustomTextField!
    @IBOutlet weak var email: CustomTextField!
    @IBOutlet weak var username: CustomTextField!
    @IBOutlet weak var singupButton: UIButton!
    var activeField: UITextField!
    var newUser: User!
    var imagePicker = UIImagePickerController()
    var tapGestureRecognizer: UITapGestureRecognizer? = nil
    var pickedImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidEmail.isHidden = true
        username.delegate = self
        password.delegate = self
        email.delegate = self
        setupLayout()
        observeKeyboardNotifications()
        imagePicker.delegate = self
        newUser = User(context: DataManager.getContext())
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        image.addGestureRecognizer(tapGestureRecognizer!)
        

        
    }
    

    fileprivate func observeKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupLayout(){
        singupButton.clipsToBounds = true
        viewImage.clipsToBounds = true
        viewImage.layer.cornerRadius = viewImage.frame.width/2
        singupButton.layer.cornerRadius = 22
        username.roundCorners(corners: .allCorners, radius: 15)
        password.roundCorners(corners: .allCorners, radius: 15)
        email.roundCorners(corners: .allCorners, radius: 15)
        password.image = UIImage(named: "pass")
        username.image = UIImage(named: "user")
        email.image = UIImage(named: "mail")
        password.setupImageView()
        username.setupImageView()
        email.setupImageView()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? FeedViewController else {return}
        dest.user = newUser ?? nil
    }
    
    @objc func keyboardWillHide(notif: Notification){
        let contentInsets = NSCoder.uiEdgeInsets(for: "")
        scView.contentInset = contentInsets
        scView.scrollIndicatorInsets = contentInsets
    }
    

    @IBAction func singup(_ sender: Any) {
        if(RegisterManager.checkTextFieldIsEmpty(textFields: [self.password, self.email, self.username])){
            let alert = UIAlertController(title: "Complete all the fields", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }else{
            guard let email = self.email.text, let password = self.password.text,let username = self.username.text else {
                let alert = UIAlertController(title: "Check all the fields!", message: nil, preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                    let when = DispatchTime.now() + 3
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                return
            }
            RegisterManager.validateEmail(email:email) { (error, isValid, suggestionEmail) in
                if !(error == nil){
                    return
                }
                if isValid {
                    DispatchQueue.main.async {
                        self.invalidEmail.isHidden = true
                        guard let imageUser = self.image.image else {
                            guard let imageDefault = UIImage(named: "user") else {
                                self.newUser.photo = ""
                                DataManager.saveContext()
                                return
                            }
                            self.newUser.photo = StoreManager.saving(image:imageDefault, withName: self.pickedImageName ?? "profilePhoto")
                            DataManager.saveContext()
                            return
                        }
                        self.newUser.photo = StoreManager.saving(image:imageUser, withName: self.pickedImageName ?? "profilePhoto")
                    }
                    self.newUser.email = email
                    self.newUser.password = password
                    self.newUser.username = username
                    DataManager.saveContext()
                    
                    self.performSegue(withIdentifier: "registerTo", sender: nil)
                    
                }else{
                    DispatchQueue.main.async {
                        self.invalidEmail.isHidden = false
                        self.invalidEmail.shake()
                    }
                    
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
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.imagePicker.sourceType = .camera
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let galeriaAction = UIAlertAction(title: "Library", style: .default)
        { _ in
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(galeriaAction)
        
        self.present(actionSheet, animated: true, completion: nil)
        
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
                self.image.bounds = self.viewImage.bounds
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

