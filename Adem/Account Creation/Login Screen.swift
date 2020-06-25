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
//import FirebaseFirestore

class login: UIViewController, UITextFieldDelegate {
    
    //MARK: Login Views
    var userInfoCaptureElements = loginInfoView()
    var buttonsUsedToLogIn = loginButtonView()
    var maybeButton = navigationButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        docRef = Firestore.firestore().document("\(userNames)")
    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        //MARK: textfield nav
        userInfoCaptureElements.emailTextField.delegate = self
        userInfoCaptureElements.passwordTextField.delegate = self
        
        
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

//        handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
//
//        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        firebaseAuth.removeStateDidChangeListener(handle!)
    }

    @objc func handelLogin() {
        //Making sure that credentials are correct
        guard let email = userInfoCaptureElements.emailTextField.text, !email.isEmpty, let password = userInfoCaptureElements.passwordTextField.text, !password.isEmpty else {
            incorrectInformationAlert(title: "Login Failed", message: "It doesn't work like that...")
            //https://www.youtube.com/watch?v=1HN7usMROt8
            //50:22
            return
        }
        
        //User: Signed in with email
        
        firebaseAuth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
//            strongSelf.navigationController?.popViewController(animated: true)
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
            let listController = tabBar()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = listController
            appDelegate.window?.makeKeyAndVisible()
            print("Successfully logged in")
            }
        }
    }
    

    func incorrectInformationAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField
        {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
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

    @objc func handelFacebooksignUp() {

    }
    
    @objc func handelGooglesignUp() {
        let signUpInfos = userFlowViewControllerTwo()
        self.present(signUpInfos, animated: true, completion: nil)
     print("Sending user to sign up Flow")
    }
    
    @objc func handelTwittersignUp() {
        
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
        
        Auth.auth().signInAnonymously() { (authResult, error) in
          guard let user = authResult?.user else { return }
          let isAnonymous = user.isAnonymous  // true
          let uid = user.uid
        db.collection("Users").document(authResult!.user.uid).collection("private").document("UsersPrivateInfo").setData([
            "isAnonymous": isAnonymous,
            "uid": uid
            
        ]) { (error) in


            if let error = error {
                print("Error creating documents: \(error.localizedDescription)")
            }
        }
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let skipAccountCreation = tabBar()
        appDelegate.window?.rootViewController = skipAccountCreation
    }
    
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
        view.addSubview(maybeButton)
        
        
        maybeButton.translatesAutoresizingMaskIntoConstraints = false
        userInfoCaptureElements.translatesAutoresizingMaskIntoConstraints = false
        buttonsUsedToLogIn.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpButtons() {
        
        //MARK: Middle Buttons
        buttonsUsedToLogIn.signUpButton.largeNextButton.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
        buttonsUsedToLogIn.loginButton.largeNextButton.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        
        //MARK: Bottom Buttons
        facebookLoginImage.roundLoginImage.addTarget(self, action: #selector(handelFacebooksignUp), for: .touchUpInside)
        facebookLoginImage.roundLoginImage.setImage(UIImage.init(named: "facebookIcon"), for: .normal)        //facebookLoginImage.roundLoginImage.layer.cornerRadius = 30
        twitterLoginImage.roundLoginImage.setImage(UIImage.init(named: "appleIcon"), for: .normal)

        twitterLoginImage.roundLoginImage.addTarget(self, action: #selector(handelTwittersignUp), for: .touchUpInside)
        GoogleLoginImage.roundLoginImage.addTarget(self, action: #selector(handelGooglesignUp), for: .touchUpInside)
        maybeButton.largeNextButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        maybeButtonAttributes()
     }
    
    private func maybeButtonAttributes() {
        maybeButton.largeNextButton.setTitle("Maybe Later", for: .normal)
        maybeButton.largeNextButton.titleLabel?.font = UIFont(name: productFont, size: 12)
        maybeButton.largeNextButton.setTitleColor(UIColor.white, for: .normal)
        maybeButton.largeNextButton.backgroundColor = UIColor.clear
    }
    
    var facebookLoginImage = roundButtonView()
    var twitterLoginImage = roundButtonView()
    var GoogleLoginImage = roundButtonView()
    
    private func setUpStackView() {
        
        let differentSignUpMethodsStackView = UIStackView(arrangedSubviews: [facebookLoginImage, twitterLoginImage, GoogleLoginImage])
        differentSignUpMethodsStackView.contentMode = .scaleAspectFit
        //differentSignUpMethodsStackView.spacing = 5
        differentSignUpMethodsStackView.distribution = .equalSpacing
        
        
        view.addSubview(differentSignUpMethodsStackView)
        differentSignUpMethodsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupconstraints() {
 
        let differentSignUpMethodsStackView = UIStackView(arrangedSubviews: [facebookLoginImage, twitterLoginImage, GoogleLoginImage])
        differentSignUpMethodsStackView.contentMode = .scaleAspectFit
        //differentSignUpMethodsStackView.spacing = 5
        differentSignUpMethodsStackView.distribution = .equalSpacing
        
        
        view.addSubview(differentSignUpMethodsStackView)
        differentSignUpMethodsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            ademImageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
//            ademImageHolder.heightAnchor.constraint(equalToConstant: 255),
            ademImageHolder.bottomAnchor.constraint(equalTo: userInfoCaptureElements.topAnchor, constant: -55),
        
            userInfoCaptureElements.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor, constant: 55),
            userInfoCaptureElements.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userInfoCaptureElements.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userInfoCaptureElements.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            userInfoCaptureElements.heightAnchor.constraint(equalToConstant: 95),
            
            buttonsUsedToLogIn.topAnchor.constraint(equalTo: userInfoCaptureElements.bottomAnchor, constant: 12),
            buttonsUsedToLogIn.centerXAnchor.constraint(equalTo: userInfoCaptureElements.centerXAnchor),
            buttonsUsedToLogIn.widthAnchor.constraint(equalTo: userInfoCaptureElements.widthAnchor),
            buttonsUsedToLogIn.heightAnchor.constraint(equalToConstant: 100),
          
            differentSignUpMethodsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            differentSignUpMethodsStackView.bottomAnchor.constraint(equalTo: maybeButton.topAnchor),
            differentSignUpMethodsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            differentSignUpMethodsStackView.heightAnchor.constraint(equalToConstant: 60),
            
            maybeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            maybeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            maybeButton.widthAnchor.constraint(equalTo: differentSignUpMethodsStackView.widthAnchor, constant: -100),
            maybeButton.heightAnchor.constraint(equalToConstant: 60),
            

        ])
        
    }
}
