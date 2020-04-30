//
//  accountCreationViews.swift
//  Adem
//
//  Created by Coleman Coats on 1/25/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Login text fields view
class userCreationInfo: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
   
    
    setUpSubviews()
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setUpSubviews()
    setupView()
  }
  
    //Name Section
    let firstNameTextField: UITextField = {
        let firstName = UITextField()
        firstName.tag = 0
        firstName.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        firstName.translatesAutoresizingMaskIntoConstraints = false
        firstName.textColor = UIColor.white
        firstName.returnKeyType = .continue
        
        return firstName
    }()
    
    let firstNameTextSeparator: UIView = {
        let firstTextSeparator = UIView()
        firstTextSeparator.backgroundColor = UIColor.white
        firstTextSeparator.translatesAutoresizingMaskIntoConstraints = false
        return firstTextSeparator
    }()
    
    let lastNameTextField: UITextField = {
        let lastName = UITextField()
        lastName.tag = 1
        lastName.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        lastName.textColor = UIColor.white
        
        lastName.returnKeyType = .continue
        lastName.translatesAutoresizingMaskIntoConstraints = false

        return lastName
    }()
    
    //Email Section
    let emailTextField: UITextField = {
        let email = UITextField()
        email.tag = 2
        email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        email.textColor = UIColor.white
        email.returnKeyType = .continue
        email.translatesAutoresizingMaskIntoConstraints = false

        return email
    }()
    
    let emailTextSeparator: UIView = {
        let emailSeparator = UIView()
        emailSeparator.backgroundColor = UIColor.white
        emailSeparator.translatesAutoresizingMaskIntoConstraints = false
        return emailSeparator
    }()
    
    //Password Section
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.tag = 3
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.isSecureTextEntry = true
        password.returnKeyType = .continue
        password.textColor = UIColor.white
        password.translatesAutoresizingMaskIntoConstraints = false

        
        return password
    }()
    
    let passwordTextSeparator: UIView = {
        let passwordSeparator = UIView()
        passwordSeparator.backgroundColor = UIColor.white
        passwordSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordSeparator
    }()
    
    private func setUpSubviews() {
        
        //Subviews
        self.addSubview(firstNameTextField)
        self.addSubview(lastNameTextField)
        self.addSubview(firstNameTextSeparator)
        self.addSubview(emailTextField)
        self.addSubview(emailTextSeparator)
        self.addSubview(passwordTextField)
        self.addSubview(passwordTextSeparator)
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    }
       
  //common func to init our view
  private func setupView() {
    
    
    let namesStackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField])
    namesStackView.contentMode = .scaleAspectFit
    namesStackView.spacing = 5
    namesStackView.translatesAutoresizingMaskIntoConstraints = false
    namesStackView.distribution = .fillEqually
    
    self.addSubview(namesStackView)
    
    NSLayoutConstraint.activate([
        
        //Social Buttons
        namesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        namesStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        namesStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24),
        namesStackView.heightAnchor.constraint(equalToConstant: 60),
        
        //First name separator
        firstNameTextSeparator.leftAnchor.constraint(equalTo: self.leftAnchor),
        firstNameTextSeparator.topAnchor.constraint(equalTo: namesStackView.bottomAnchor),
        firstNameTextSeparator.widthAnchor.constraint(equalTo: self.widthAnchor),
        firstNameTextSeparator.heightAnchor.constraint(equalToConstant: 1),
        
        //Email text
        emailTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
        emailTextField.topAnchor.constraint(equalTo: firstNameTextSeparator.bottomAnchor),
        emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24),
        emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5),
        
        //Name separator
        emailTextSeparator.leftAnchor.constraint(equalTo: self.leftAnchor),
        emailTextSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
        emailTextSeparator.widthAnchor.constraint(equalTo: self.widthAnchor),
        emailTextSeparator.heightAnchor.constraint(equalToConstant: 1),
        
        //Password text
        passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
        passwordTextField.topAnchor.constraint(equalTo: emailTextSeparator.bottomAnchor),
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24),
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5),
        
        //Password separator
        passwordTextSeparator.leftAnchor.constraint(equalTo: self.leftAnchor),
        passwordTextSeparator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
        passwordTextSeparator.widthAnchor.constraint(equalTo: self.widthAnchor),
        passwordTextSeparator.heightAnchor.constraint(equalToConstant: 1),
    ])
  }
}
