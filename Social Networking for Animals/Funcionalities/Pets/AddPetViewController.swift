//
//  AddPetViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 27/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class AddPetViewController: UIViewController {
    @IBOutlet weak var name: DesignableUITextField!
    @IBOutlet weak var imagePet: UIImageView!
    @IBOutlet weak var scView: UIScrollView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var age: DesignableUITextField!
    @IBOutlet weak var birthdayYear: DesignableUITextField!
    @IBOutlet weak var breed: DesignableUITextField!
    @IBOutlet weak var kindOfAnimal: DesignableUITextField!
    
    var imagePicker = UIImagePickerController()
    var pickedImageName: String?
    var activeField: UITextField!
    var tapGestureRecognizer:UITapGestureRecognizer? =  nil
    var newPet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        observeKeyboardNotifications()
        imagePicker.delegate = self
        newPet = Pet(context: DataManager.getContext())
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        self.imagePet.addGestureRecognizer(tapGestureRecognizer!)

        // Do any additional setup after loading the view.
    }
    
    func setupLayout(){
        viewImage.clipsToBounds = true
        viewImage.layer.cornerRadius = viewImage.frame.width/2
    }
    fileprivate func observeKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
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
    @objc func keyboardWillHide(notif: Notification){
        let contentInsets = NSCoder.uiEdgeInsets(for: "")
        scView.contentInset = contentInsets
        scView.scrollIndicatorInsets = contentInsets
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
    

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        if(RegisterManager.checkTextFieldIsEmpty(textFields: [self.age, self.birthdayYear, self.breed, self.name, self.kindOfAnimal])){
            let alert = UIAlertController(title: "Complete all the fields", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }else{
            guard let age = self.age.text, let birthbayYear = self.birthdayYear.text,let breed = self.breed.text, let name = self.name.text, let kindOfAnimal = self.kindOfAnimal.text, let newPet = self.newPet  else {
                let alert = UIAlertController(title: "Complete all the fields!", message: nil, preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true, completion: nil)
                }
                return
            }
            newPet.name = name
            newPet.age = Int16(age) ?? 0
            newPet.breed = breed
            newPet.followersCount = 0
            newPet.likeCount = 0
            newPet.photoCount = 0
            newPet.type = kindOfAnimal
            newPet.birthdayYear = birthbayYear
            newPet.owner = LoginManager.getUserLogged()
            DataManager.saveContext()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}


extension AddPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.imagePet.image = imagePicked
                self.imagePet.bounds = self.viewImage.bounds
                //self.imagePet.contentMode = .scaleAspectFill
            }
            self.pickedImageName = "Petgram\(imagePicked.hashValue)"
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
