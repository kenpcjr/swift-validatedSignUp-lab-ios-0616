//
//  ViewController.swift
//  ValidatedSignUp
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let alert = UIAlertController.init(title: "Nope", message: "", preferredStyle: .Alert )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
        
        let alertOption1 = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        
        
        
        alert.addAction(alertOption1)
        
        signUpButton.enabled = false
        
        
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //        print(textField)
        
        validateFields(textField)
        
        return false
    }
    
    
    func validateFields(textField: UITextField) -> Bool{
        
        if let field = textField.placeholder {
            
            switch field {
                
            case "First Name":
                
                if validateName(textField) == true {
                    
                    firstNameTextField.resignFirstResponder()
                    lastNameTextField.enabled = true
                    lastNameTextField.becomeFirstResponder()
                    
                } else {
                    
                    alert.message = "Please enter a valid first name"
                    
                    customizeAlert(textField)
                    
                    
                }
                
            case "Last Name":
                
                if validateName(textField) == true {
                    
                    lastNameTextField.resignFirstResponder()
                    emailTextField.enabled = true
                    emailTextField.becomeFirstResponder()
                    
                    
                    
                } else {
                    
                    alert.message = "Please enter a valid last name"
                    
                    customizeAlert(textField)
                    
                    
                }
                
            case "Email Address":
                
                if validateEmail(textField) == true {
                    
                    lastNameTextField.resignFirstResponder()
                    userNameTextField.enabled = true
                    userNameTextField.becomeFirstResponder()
                    
                } else {
                    
                    alert.message = "Please enter a valid email"
                    
                    customizeAlert(textField)
                    
                }
                
                case "User Name":
                
                    if validateName(textField) {
                        
                        
                        emailTextField.resignFirstResponder()
                        passwordTextField.enabled = true
                        passwordTextField.becomeFirstResponder()
                        
                    } else {
                        
                        alert.message = "Please enter a valid Username"
                        
                        customizeAlert(textField)
                        
                }
                
                case "Password":
                
                    if textField.text?.characters.count > 0 {
                        
                        signUpButton.enabled = true
                        
                    } else {
                        
                        alert.message = "Please enter a valid password"
                        
                        customizeAlert(textField)
                }
                
                
                
            default:
                
                return false
                
            }
        }
        
        return false
    }
    
    func validateName(textField: UITextField) -> Bool {
        
        let hasCharacters = textField.text?.characters.count > 0
        
        
        let characterSet = NSCharacterSet.letterCharacterSet()
        
        
        let hasNoNumbers = textField.text?.rangeOfCharacterFromSet(characterSet.invertedSet) == nil
        
        if hasCharacters && hasNoNumbers {
            
            return true
            
        }
        
        return false
        
    }
    
    func validateEmail(textField: UITextField) -> Bool {
        
        if validateEmailContent(textField) && textField.text?.characters.count > 0 {
    
        
            return true
            
        }
        
        return false
    }
    
    func customizeAlert(textField: UITextField){
        
        let alertOption2 = UIAlertAction.init(title: "Clear", style: UIAlertActionStyle.Destructive, handler: {(alert: UIAlertAction) in (textField.text = "")})
        alert.addAction(alertOption2)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func validateEmailContent(textField: UITextField) -> Bool {
        
        
        let expression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", expression)
        
        return emailTest.evaluateWithObject(textField.text)
        
        
    }
    
 
}
