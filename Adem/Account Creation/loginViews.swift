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
  
    let loginButton: UIButton = {
        let login = UIButton(type: .system)
        login.backgroundColor = UIColor.white
        login.setTitle("Login", for: .normal)
        login.translatesAutoresizingMaskIntoConstraints = false
        login.titleLabel?.font = UIFont(name: headerFont, size: 20)
        login.layer.cornerRadius = 5
        login.layer.masksToBounds = true
        login.setTitleColor(UIColor.ademBlue, for: .normal)
        login.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return login
    }()
    
    let signUpButton: UIButton = {
        let signUp = UIButton()
        signUp.setTitle("Sign Up", for: .normal)
        signUp.setTitleColor(UIColor.white, for: .normal)
        signUp.titleLabel?.font = UIFont(name: buttonFont, size: 20)
        signUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUp.translatesAutoresizingMaskIntoConstraints = false
        return signUp
    }()
       
  //common func to init our view
  private func setupView() {

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
class socialButtonView: UIView {
  
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
  
    
    let maybeLaterButton: UIButton = {
        let maybeLater = UIButton(type: .system)
        maybeLater.setTitle("Maybe Later", for: .normal)
        maybeLater.titleLabel?.font = UIFont(name: productFont, size: 12)
        maybeLater.setTitleColor(UIColor.white, for: .normal)
        return maybeLater
    }()
    
    let facebookLoginImage: UIButton = {
        let facebookLogin = UIButton(type: .system)
        facebookLogin.setImage(UIImage.init(named: "Home"), for: .normal)
        facebookLogin.layer.cornerRadius = 30
        facebookLogin.layer.borderWidth = 0.50
        facebookLogin.backgroundColor = UIColor.white
        facebookLogin.widthAnchor.constraint(equalToConstant: 60).isActive = true
        facebookLogin.translatesAutoresizingMaskIntoConstraints = false
        return facebookLogin
    }()
    
    let twitterLoginImage: UIButton = {
        let twitterLogin = UIButton(type: .system)
        twitterLogin.setImage(UIImage.init(named: "Home"), for: .normal)
        twitterLogin.layer.cornerRadius = 30
        twitterLogin.layer.borderWidth = 0.50
        twitterLogin.backgroundColor = UIColor.white
        twitterLogin.widthAnchor.constraint(equalToConstant: 60).isActive = true
        twitterLogin.translatesAutoresizingMaskIntoConstraints = false
        return twitterLogin
    }()
    
    let GoogleLoginImage: UIButton = {
        let googleLogin = UIButton(type: .system)
        googleLogin.setImage(UIImage.init(named: "Home"), for: .normal)
        googleLogin.layer.cornerRadius = 30
        googleLogin.layer.borderWidth = 0.50
        googleLogin.backgroundColor = UIColor.white
        googleLogin.widthAnchor.constraint(equalToConstant: 60).isActive = true
        googleLogin.translatesAutoresizingMaskIntoConstraints = false
        return googleLogin
    }()
    
  //common func to init our view
  private func setupView() {

    self.layer.masksToBounds = true
    
    self.addSubview(maybeLaterButton)
    maybeLaterButton.translatesAutoresizingMaskIntoConstraints = false
    
    
    let differentSignUpMethodsStackView = UIStackView(arrangedSubviews: [facebookLoginImage, twitterLoginImage, GoogleLoginImage])
    differentSignUpMethodsStackView.contentMode = .scaleAspectFit
    //differentSignUpMethodsStackView.spacing = 5
    differentSignUpMethodsStackView.distribution = .equalSpacing
    
    
    self.addSubview(differentSignUpMethodsStackView)
    differentSignUpMethodsStackView.translatesAutoresizingMaskIntoConstraints = false
    
    
    NSLayoutConstraint.activate([
        
        differentSignUpMethodsStackView.topAnchor.constraint(equalTo: self.topAnchor),
        differentSignUpMethodsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        differentSignUpMethodsStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
        differentSignUpMethodsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
        

        maybeLaterButton.topAnchor.constraint(equalTo: differentSignUpMethodsStackView.bottomAnchor),
        maybeLaterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        maybeLaterButton.widthAnchor.constraint(equalTo: self.widthAnchor),
        maybeLaterButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
    ])
  }
}


//MARK: Login button view
class preferenceProgressViews: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    self.layer.masksToBounds = true
    self.backgroundColor = UIColor.ademGreen
    
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }
  
    let closePreferencesButton: UIButton = {
        let login = UIButton(type: .system)
        //login.backgroundColor = UIColor.ademBlue
        login.setTitle("X", for: .normal)
        login.translatesAutoresizingMaskIntoConstraints = false
        //login.titleLabel?.font = UIFont(name: productFont, size: 20)
        login.layer.cornerRadius = 5
        login.layer.masksToBounds = true
        login.setTitleColor(UIColor.white, for: .normal)
        login.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return login
    }()
    
    let pBar: UIProgressView = {
        let progressViewBar = UIProgressView(progressViewStyle: .default)
        progressViewBar.setProgress(0.00, animated: true)
        progressViewBar.trackTintColor = UIColor.white
//        progressViewBar.tintColor = UIColor.ademGreen
        progressViewBar.tintColor = UIColor.ademBlue

        
        return progressViewBar
    }()
    
    let ademImageButton: UIButton = {
        let infoImage = UIImage(named: "Info")
        let signUp = UIButton()
        signUp.setImage(infoImage, for: .normal)
        signUp.setTitleColor(UIColor.white, for: .normal)
        signUp.titleLabel?.font = UIFont(name: buttonFont, size: 20)
        signUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUp.translatesAutoresizingMaskIntoConstraints = false
        return signUp
    }()
       
  //common func to init our view
  private func setupView() {

    
    
    
    self.addSubview(closePreferencesButton)
    self.addSubview(pBar)
    self.addSubview(ademImageButton)
    
    closePreferencesButton.translatesAutoresizingMaskIntoConstraints = false
    ademImageButton.translatesAutoresizingMaskIntoConstraints = false
    pBar.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
        
        closePreferencesButton.topAnchor.constraint(equalTo: self.topAnchor),
        closePreferencesButton.leftAnchor.constraint(equalTo: self.leftAnchor),
        closePreferencesButton.widthAnchor.constraint(equalToConstant: 50),
        closePreferencesButton.heightAnchor.constraint(equalTo: self.heightAnchor),
        
        
        pBar.leftAnchor.constraint(equalTo: closePreferencesButton.rightAnchor, constant: 25),

        pBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        pBar.rightAnchor.constraint(equalTo: ademImageButton.leftAnchor, constant: -25),

        ademImageButton.topAnchor.constraint(equalTo: self.topAnchor),
        ademImageButton.rightAnchor.constraint(equalTo: self.rightAnchor),
        ademImageButton.widthAnchor.constraint(equalToConstant: 50),
        ademImageButton.heightAnchor.constraint(equalTo: self.heightAnchor),
    ])
  }
}

//MARK: Login button view
class preferenceNextViews: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    self.layer.masksToBounds = true
    self.backgroundColor = UIColor.ademGreen
    //self.layer.cornerRadius = 5
    
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }
    
   //Next Button
    let nextButton: UIButton = {
        //This just refreshes the table view and the labels
        let nextPage = UIButton(type: .system)
        nextPage.backgroundColor = UIColor.ademBlue
        nextPage.setTitle("Next", for: .normal)
        nextPage.translatesAutoresizingMaskIntoConstraints = false
        nextPage.layer.cornerRadius = 5
        nextPage.layer.masksToBounds = true
        nextPage.setTitleColor(UIColor.white, for: .normal)
        nextPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return nextPage
        
    }()
    
    let pBar: UIProgressView = {
        let progressViewBar = UIProgressView(progressViewStyle: .bar)
            progressViewBar.setProgress(0.25, animated: true)
            progressViewBar.trackTintColor = UIColor.white
    //        progressViewBar.tintColor = UIColor.ademGreen
            progressViewBar.tintColor = UIColor.ademGreen
        //progressViewBar.layer.cornerRadius = 5
        //progressViewBar.clipsToBounds = true

            
            return progressViewBar
        }()
       
  //common func to init our view
  private func setupView() {

    self.backgroundColor = UIColor.white
    
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
