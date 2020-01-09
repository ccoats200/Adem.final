//
//  loginViews.swift
//  Adem
//
//  Created by Coleman Coats on 1/8/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore


//MARK: Product name view
class loginInfoView: UIView, UITextFieldDelegate {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    emailTextField.delegate = self
    passwordTextField.delegate = self
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
    let emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.returnKeyType = .continue
        email.autocapitalizationType = .none
        email.textColor = UIColor.black
        email.tag = 0
        email.translatesAutoresizingMaskIntoConstraints = false
        
        return email
       }()
       
       let textFieldSeparator: UIView = {
           let textSeparator = UIView()
           textSeparator.backgroundColor = UIColor.ademBlue
           textSeparator.translatesAutoresizingMaskIntoConstraints = false
           return textSeparator
       }()
       
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.returnKeyType = .done
        password.translatesAutoresizingMaskIntoConstraints = false
        password.tag = 1
        
        return password
       }()
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        print(textField.tag)
        return false
    }
    
       
  //common func to init our view
  private func setupView() {
    
    self.backgroundColor = UIColor.white
    self.layer.cornerRadius = 5
    self.layer.borderColor = UIColor.gray.cgColor
    self.layer.borderWidth = 1
    self.layer.masksToBounds = true
    
    self.addSubview(emailTextField)
    self.addSubview(textFieldSeparator)
    self.addSubview(passwordTextField)
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false

    //self.clipsToBounds = true
    //self.layer.cornerRadius = 20
    
    
    NSLayoutConstraint.activate([
        
        emailTextField.topAnchor.constraint(equalTo: self.topAnchor),
        emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant:  -24),
        emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: (1/2)),
        
        textFieldSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
        textFieldSeparator.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
        textFieldSeparator.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24),
        textFieldSeparator.heightAnchor.constraint(equalToConstant: 1),
        

        passwordTextField.topAnchor.constraint(equalTo: textFieldSeparator.bottomAnchor),
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24),
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: (1/2)),
    ])
  }
}
