//
//  Login Screen.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore


class login: UIViewController, UITextFieldDelegate {
    
    // Add a new document with a generated ID
    //let minimuPasswordCount = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docRef = Firestore.firestore().document("\(userNames)")
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.ademBlue.cgColor,UIColor.ademGreen.cgColor]
        //Top left
        gradient.startPoint = CGPoint(x: 0, y: 0)
        //Top right
        gradient.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(gradient)
        
        view.addSubview(ademImageHolder)
        view.addSubview(loginFieldView)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        
        //setupademImageHolder()
        setuploginFieldView()
        
    }
    //Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, User) in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    
    func incorrectInformationAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handelLogin()
    {
        //Making sure that credentials are correct
        guard let email = self.emailTextField.text, !email.isEmpty, let password = self.passwordTextField.text, !password.isEmpty else {
            incorrectInformationAlert(title: "Login Failed", message: "Please enter a valid email and password")
            return
        }
        
        print(email)
        print(password)
        
        //User: Signed in with email
        firebaseAuth.signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            
            let listController = tabBar()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = listController
            appDelegate.window?.makeKeyAndVisible()
            print("Logging in \(email)")
        }
        
        //Question: Why does this only need on click when in the signIn method but 2 outside it?
        /*
        let listController = tabBar()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = listController
        appDelegate.window?.makeKeyAndVisible()
        print("Logging in \(email)")
 */
    }

    @objc func handelSignUp() {
        
        //Check how this is transitioning and fix it for a navigation controller
        let signUpInfo = UserInfo()
        self.present(signUpInfo, animated: true, completion: nil)
        //navigationController?.pushViewController(signUpInfo, animated: true)
        print("Sending user to sign up Flow")
    }
    
    @objc func handleSkip() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let skipAccountCreation = tabBar()
        appDelegate.window?.rootViewController = skipAccountCreation
        print("Allowing user to skip the login or sign up flow")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    let loginFieldView: UIView = {
        let logintextfield = UIView()
        logintextfield.backgroundColor = UIColor.white
        logintextfield.translatesAutoresizingMaskIntoConstraints = false
        logintextfield.layer.cornerRadius = 5
        logintextfield.layer.borderWidth = 1
        logintextfield.layer.borderColor = UIColor.gray.cgColor
        logintextfield.layer.masksToBounds = true
        return logintextfield
    }()
    
    lazy var loginButton: UIButton = {
        let login = UIButton(type: .system)
        login.backgroundColor = UIColor.white
        login.setTitle("Login", for: .normal)
        login.translatesAutoresizingMaskIntoConstraints = false
        login.layer.cornerRadius = 5
        login.layer.masksToBounds = true
        login.setTitleColor(UIColor.rgb(red: 76, green: 82, blue: 111), for: .normal)
        login.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        login.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        return login
    }()
    
    lazy var signUpButton: UIButton = {
        let signUp = UIButton(type: .system)
        signUp.setTitle("Sign up", for: .normal)
        signUp.translatesAutoresizingMaskIntoConstraints = false
        signUp.setTitleColor(UIColor.white, for: .normal)
        signUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        signUp.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
        return signUp
    }()
    
    lazy var maybeLaterButton: UIButton = {
        let maybeLater = UIButton(type: .system)
        maybeLater.setTitle("Maybe Later", for: .normal)
        maybeLater.translatesAutoresizingMaskIntoConstraints = false
        maybeLater.setTitleColor(UIColor.white, for: .normal)
        maybeLater.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        maybeLater.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        return maybeLater
    }()
    
    lazy var facebookLoginImage: UIButton = {
        let facebookLogin = UIButton(type: .system)
        facebookLogin.setImage(UIImage.init(named: "Home"), for: .normal)
        facebookLogin.translatesAutoresizingMaskIntoConstraints = false
        facebookLogin.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
        facebookLogin.layer.cornerRadius = 30
        facebookLogin.layer.borderWidth = 1
        facebookLogin.backgroundColor = UIColor.white
        return facebookLogin
    }()
    
    lazy var twitterLoginImage: UIButton = {
        let twitterLogin = UIButton(type: .system)
        twitterLogin.setImage(UIImage.init(named: "Home"), for: .normal)
        twitterLogin.translatesAutoresizingMaskIntoConstraints = false
        twitterLogin.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
        twitterLogin.layer.cornerRadius = 30
        twitterLogin.layer.borderWidth = 1
        twitterLogin.backgroundColor = UIColor.white
        return twitterLogin
    }()
    
    lazy var GoogleLoginImage: UIButton = {
        let googleLogin = UIButton(type: .system)
        googleLogin.setImage(UIImage.init(named: "Home"), for: .normal)
        googleLogin.translatesAutoresizingMaskIntoConstraints = false
        googleLogin.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
        googleLogin.layer.cornerRadius = 30
        googleLogin.layer.borderWidth = 1
        googleLogin.backgroundColor = UIColor.white
        return googleLogin
    }()
    
    let userNameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "User Name"
        name.translatesAutoresizingMaskIntoConstraints = false
        
        return name
    }()
    
    let emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.translatesAutoresizingMaskIntoConstraints = false
        email.autocapitalizationType = .none
        return email
    }()
    
    let emailTextSeparator: UIView = {
        let textSeparator = UIView()
        textSeparator.backgroundColor = UIColor.lightGray
        textSeparator.translatesAutoresizingMaskIntoConstraints = false
        return textSeparator
    }()
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        
        return password
    }()
    
    let passwordTextSeparator: UIView = {
        let passwordSeparator = UIView()
        passwordSeparator.backgroundColor = UIColor.lightGray
        passwordSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordSeparator
    }()
    
    let ademImageHolder: UIImageView = {
        let ademImage = UIImageView()
        ademImage.image = UIImage(named: "Adem Logo")
        ademImage.translatesAutoresizingMaskIntoConstraints = false
        ademImage.contentMode = .scaleAspectFit
        
        return ademImage
    }()
    
    func setuploginFieldView() {
        //loginFieldView.addSubview(userNameTextField)
        loginFieldView.addSubview(emailTextField)
        loginFieldView.addSubview(emailTextSeparator)
        loginFieldView.addSubview(passwordTextField)
        
        let differentSignUpMethodsStackView = UIStackView(arrangedSubviews: [facebookLoginImage, twitterLoginImage, GoogleLoginImage])
        differentSignUpMethodsStackView.contentMode = .scaleAspectFit
        differentSignUpMethodsStackView.spacing = 5
        differentSignUpMethodsStackView.translatesAutoresizingMaskIntoConstraints = false
        differentSignUpMethodsStackView.distribution = .fillEqually
        
        view.addSubview(differentSignUpMethodsStackView)
        view.addSubview(maybeLaterButton)

        
        NSLayoutConstraint.activate([
            
            ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ademImageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            ademImageHolder.heightAnchor.constraint(equalToConstant: 255),
        
        //login Fields
            loginFieldView.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor, constant: 55),
            loginFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            loginFieldView.heightAnchor.constraint(equalToConstant: 95), //125 also looks good
        
        //Email text
            emailTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12),
            emailTextField.topAnchor.constraint(equalTo: loginFieldView.topAnchor),
            emailTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/2),
        
        //Name separator
        //emailTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: -20),
            emailTextSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            emailTextSeparator.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            emailTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor,  constant: -25),
            emailTextSeparator.heightAnchor.constraint(equalToConstant: 1),
        
        //Password text
            passwordTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12),
            passwordTextField.topAnchor.constraint(equalTo: emailTextSeparator.topAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/2),
            
         //Login Button
            loginButton.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: loginFieldView.bottomAnchor, constant: 12),
            loginButton.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
          //SignUp Button
            signUpButton.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12),
            signUpButton.widthAnchor.constraint(equalToConstant: 60),
            signUpButton.heightAnchor.constraint(equalToConstant: 20),
            
          //Social Buttons
            differentSignUpMethodsStackView.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
            differentSignUpMethodsStackView.bottomAnchor.constraint(equalTo: maybeLaterButton.topAnchor, constant: -12),
            differentSignUpMethodsStackView.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor),
            differentSignUpMethodsStackView.heightAnchor.constraint(equalToConstant: 60),
            
           //Maybe Later Button
            maybeLaterButton.centerXAnchor.constraint(equalTo: differentSignUpMethodsStackView.centerXAnchor),
            maybeLaterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            maybeLaterButton.widthAnchor.constraint(equalTo: differentSignUpMethodsStackView.widthAnchor, multiplier: 1/2),
            maybeLaterButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
        
    }
}
