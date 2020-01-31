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
    
    //MARK: Login Views
    var userInfoCaptureElements = loginInfoView()
    var buttonsUsedToLogIn = loginButtonView()
    var social = socialButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docRef = Firestore.firestore().document("\(userNames)")
    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
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
        
        
        //MARK: Setting up views
        setUpSubviews()
        setUpButtons()
        setupconstraints()
        
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

    @objc func handelLogin()
    {
        //Making sure that credentials are correct
        guard let email = userInfoCaptureElements.emailTextField.text, !email.isEmpty, let password = userInfoCaptureElements.passwordTextField.text, !password.isEmpty else {
            incorrectInformationAlert(title: "Login Failed", message: "It doesn't work like that...")
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
    
    func incorrectInformationAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userInfoCaptureElements.emailTextField.resignFirstResponder()
        userInfoCaptureElements.passwordTextField.resignFirstResponder()
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

    @objc func handelSocialsignUp() {
        
        //Check how this is transitioning and fix it for a navigation controller
     //let signUpInfo = addedFoodPreference()
        let signUpInfo = PageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        //let signUpInfo = moreInfo()
     self.present(signUpInfo, animated: true, completion: nil)
     print("Sending user to sign up Flow")
    }
    
    
    
    @objc func handelSignUp() {
        
        //Check how this is transitioning and fix it for a navigation controller
     let signUpInfo = UserInfo()
     //   let signUpInfo = moreInfo()
     //self.navigationController?.pushViewController(signUpInfo, animated: true)
     self.present(signUpInfo, animated: true, completion: nil)
     print("Sending user to sign up Flow")
    }
    
    @objc func handleSkip() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let skipAccountCreation = tabBar()
        appDelegate.window?.rootViewController = skipAccountCreation
        print("Allowing user to skip the login or sign up flow")
    }

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
        email.textColor = UIColor.black
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
    
    
    private func setUpSubviews() {
        view.addSubview(ademImageHolder)
        view.addSubview(userInfoCaptureElements)
        view.addSubview(buttonsUsedToLogIn)
        view.addSubview(social)
        userInfoCaptureElements.translatesAutoresizingMaskIntoConstraints = false
        buttonsUsedToLogIn.translatesAutoresizingMaskIntoConstraints = false
        social.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpButtons() {
        
        //MARK: Middle Buttons
        buttonsUsedToLogIn.signUpButton.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
        buttonsUsedToLogIn.loginButton.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        
        //MARK: Bottom Buttons
        social.facebookLoginImage.addTarget(self, action: #selector(handelSocialsignUp), for: .touchUpInside)
        social.maybeLaterButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
     }
    
    
    private func setupconstraints() {
 
        
        NSLayoutConstraint.activate([
            
            ademImageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            ademImageHolder.heightAnchor.constraint(equalToConstant: 255),
        
            userInfoCaptureElements.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor, constant: 55),
            userInfoCaptureElements.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userInfoCaptureElements.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userInfoCaptureElements.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            userInfoCaptureElements.heightAnchor.constraint(equalToConstant: 95), //125 also looks good
            
            buttonsUsedToLogIn.topAnchor.constraint(equalTo: userInfoCaptureElements.bottomAnchor, constant: 12),
            buttonsUsedToLogIn.centerXAnchor.constraint(equalTo: userInfoCaptureElements.centerXAnchor),
            buttonsUsedToLogIn.widthAnchor.constraint(equalTo: userInfoCaptureElements.widthAnchor),
            buttonsUsedToLogIn.heightAnchor.constraint(equalToConstant: 100),
          
            social.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            social.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            social.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            social.heightAnchor.constraint(equalToConstant: 120),

        ])
        
    }
}
