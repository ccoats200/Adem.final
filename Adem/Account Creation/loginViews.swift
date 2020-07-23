//
//  loginViews.swift
//  Adem
//
//  Created by Coleman Coats on 1/8/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Login text fields view
class loginInfoView: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
   
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

//MARK: Login button view
class loginButtonView: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }
  
    
    var loginButton = navigationButton()
    var signUpButton = navigationButton()
    
    private func setUpButtons() {
        //MARK: login button
        loginButton.largeNextButton.backgroundColor = UIColor.white
        loginButton.largeNextButton.setTitle("Login", for: .normal)
        loginButton.largeNextButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.largeNextButton.layer.masksToBounds = true
        loginButton.largeNextButton.setTitleColor(UIColor.ademBlue, for: .normal)
        
        //MARK: Sign up button
        signUpButton.largeNextButton.setTitle("Sign Up", for: .normal)
        signUpButton.largeNextButton.backgroundColor = UIColor.clear
        signUpButton.largeNextButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.largeNextButton.titleLabel?.font = UIFont(name: buttonFont, size: 20)
        signUpButton.largeNextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpButton.largeNextButton.translatesAutoresizingMaskIntoConstraints = false
    }
       
  //common func to init our view
  private func setupView() {

    setUpButtons()
    self.layer.masksToBounds = true
    
    self.addSubview(loginButton)
    self.addSubview(signUpButton)
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    signUpButton.translatesAutoresizingMaskIntoConstraints = false
    
    
    NSLayoutConstraint.activate([
        
        loginButton.topAnchor.constraint(equalTo: self.topAnchor),
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant:  -24),
        loginButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),

        signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor),
        signUpButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        signUpButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24),
        signUpButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
    ])
  }
}

//MARK: Social button view
class roundButtonView: UIView {
  
    //initWithFrame to init view from code
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
  
  //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        setupView()
    }
    
    let roundLoginImage: UIButton = {
//        https://www.iconfinder.com/icons/1298745/google_icon
        let socialLogin = UIButton(type: .system)
        socialLogin.setImage(UIImage.init(named: "twitterIcon"), for: .normal)
        socialLogin.contentMode = .scaleAspectFit
        socialLogin.contentMode = .center
        socialLogin.layer.cornerRadius = 5
        
        socialLogin.backgroundColor = UIColor.white
        socialLogin.widthAnchor.constraint(equalToConstant: 60).isActive = true
        socialLogin.translatesAutoresizingMaskIntoConstraints = false
        return socialLogin
    }()
    
  //common func to init our view
  private func setupView() {

    self.layer.masksToBounds = true

    self.addSubview(roundLoginImage)
    roundLoginImage.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        
        roundLoginImage.topAnchor.constraint(equalTo: self.topAnchor),
        roundLoginImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        roundLoginImage.widthAnchor.constraint(equalTo: self.widthAnchor),
        roundLoginImage.heightAnchor.constraint(equalTo: self.heightAnchor),
    ])
  }
}

//MARK: Login button view
class preferenceNextButtonView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
    
        setupView()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    var nextButton = navigationButton()
    
    let pBar: UIProgressView = {
        let progressViewBar = UIProgressView(progressViewStyle: .bar)
        progressViewBar.setProgress(0.25, animated: true)
        progressViewBar.trackTintColor = UIColor.white
        progressViewBar.tintColor = UIColor.ademGreen
        return progressViewBar
    }()
  
    private func setupView() {
        nextButton.largeNextButton.setTitle("Next", for: .normal)
    

        self.addSubview(nextButton)
        self.addSubview(pBar)
    
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        pBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
    
            pBar.heightAnchor.constraint(equalToConstant: 8),
            pBar.widthAnchor.constraint(equalTo: self.widthAnchor),
            pBar.topAnchor.constraint(equalTo: self.topAnchor),
            pBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
            nextButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
