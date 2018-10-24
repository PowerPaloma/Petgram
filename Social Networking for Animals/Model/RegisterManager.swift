//
//  ParserTextField.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 23/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class RegisterManager {
    
    static func checkTextFieldIsEmpty(textFields: [UITextField]) -> Bool{
        for textField in textFields{
            if textField.text == "" {
                return true
            }
        }
        return false
    }
    
    static func validateEmail(email: String, completion: @escaping (Error?, Bool, String?) -> Void){
        APIManager.validate(emailAddress: email) { (error, isValid, emailSuggestion) in
            if !(error == nil){
                completion(error, false, nil)
            }
            guard let isValid = isValid else {
                completion(error, false, nil)
                return
            }
            if isValid {
                completion(nil, true, nil)
            }else{
                completion(nil, false, emailSuggestion)
            }
        }
        
    }
}
