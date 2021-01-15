//
//  SignUpInfo.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase


enum signUpErrors: Error {
    case passwordInvalid
    case emailInvalid
    case empty
}

class UserInfo: UIViewController, UITextFieldDelegate {
        
    
//    MARK: - Vars and Lets START
    let minimuPasswordLength = 6
    var handle: AuthStateDidChangeListenerHandle?
//    MARK: Vars and Lets END -

    
//    MARK: - Views START
    var accountCreationViews = userCreationInfo()
    var nextButton = navigationButton()
//    MARK: Views END -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
//        MARK: textfield nav
        accountCreationViews.firstNameTextField.delegate = self
        accountCreationViews.lastNameTextField.delegate = self
        accountCreationViews.emailTextField.delegate = self
        accountCreationViews.passwordTextField.delegate = self
        

//        MARK: - Gradient Backgound Color START
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.ademBlue.cgColor,UIColor.ademGreen.cgColor]
        //Top left
        gradient.startPoint = CGPoint(x: 0, y: 0)
        //Top right
        gradient.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(gradient)
//        MARK: Gradient Backgound Color END -
        
//        MARK: function Calls for views
        setUpSubviews()
        setuploginFieldView()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
//    MARK: - Buttons START
    @objc func handelNext() {
        guard let firstName = accountCreationViews.firstNameTextField.text, !firstName.isEmpty else {
            self.showMessagePrompt(title: "You forgot something", message: "What should we call you", button: "Retry")
            return
        }
        guard let lastName = accountCreationViews.lastNameTextField.text, !lastName.isEmpty else {
            self.showMessagePrompt(title: "You forgot something \(firstName)", message: "Last name or initial", button: "Retry")
            return
        }
        guard let email = accountCreationViews.emailTextField.text, (!email.isEmpty && email.contains(".com")) else {
            self.showMessagePrompt(title: "Email Invalid", message: "Must be a valid email address", button: "Retry")
            return
        }
        guard let password = accountCreationViews.passwordTextField.text, (!password.isEmpty && password.count > 6) else {
            self.showMessagePrompt(title: "Password Invalid", message: "Must be a valid password. Must include a special character and number", button: "Retry")
            return
        }
//        MARK: - Create User START
        firebaseAuth.createUser(withEmail: accountCreationViews.emailTextField.text!, password: accountCreationViews.passwordTextField.text!) { authResult, error in
            //https://medium.com/firebase-developers/ios-firebase-authentication-sdk-email-and-password-login-6a3bb27e0536
            if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    print("not Allowed")
                case .emailAlreadyInUse:
                    print("in Use")
                case .invalidEmail:
                    print("invalid")
                case .weakPassword:
                    print("weak")
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                //MARK: Home section in Firebase
                db.collection("home").document(authResult!.user.uid).collection("members").document(authResult!.user.uid).collection("private").document("usersPrivateData").setData([
                    "home": authResult!.user.uid,
                    "FirstName": firstName,
                    "LastName": lastName,
                    "Email": email,
                    "Password": password,
                    "uid": authResult!.user.uid,
                    "isAnonymous": authResult!.user.isAnonymous,
                    "homeName": "Kitchen"
                ]) { (error) in
                    if let error = error {
                        print("Error creating documents: \(error.localizedDescription)")
                    }
                }
                //db.collection("home").document(authResult!.user.uid).collection("members").document(authResult!.user.uid).collection("public").document("products").collection("List").document()
            }
        }
//    MARK: Create User END -
        sendToSignUpFlow()
    }
    
    func sendToSignUpFlow() {
//        MARK: Sending to the next screen in the sign up flow
        let moreController = addedDietPreferencesTwo()
        moreController.resignFirstResponder()
        if #available(iOS 13.0, *) {
            moreController.isModalInPresentation = true
            //https://developer.apple.com/documentation/uikit/uiadaptivepresentationcontrollerdelegate/3229888-presentationcontrollerdidattempt
        } else {
            // Fallback on earlier versions
        }
        self.present(moreController, animated: true, completion: nil)
    }
//    MARK: Buttons END -
    
//    MARK:- Sign up Checks START
    func isValidEmail(_ email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
      let minPasswordLength = 6
      return password.count >= minPasswordLength
    }
//    MARK: Sign up Checks END -
    
    func showMessagePrompt(title: String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//    MARK: - GUI Elements Start
    
    let scrollView: UIScrollView = {
        let scrolling = UIScrollView()
        scrolling.backgroundColor = UIColor.clear
        scrolling.translatesAutoresizingMaskIntoConstraints = false
        //scrolling.contentSize.height = 500
        //scrolling.layer.masksToBounds = true
        return scrolling
    }()
    
    let welcomeLabel: UILabel = {
        let welcome = UILabel()
        welcome.text = "Welcome to Adem"
        welcome.textAlignment = .center
        welcome.textColor = UIColor.white
        welcome.font = UIFont(name:"HelveticaNeue", size: 20.0)
        //welcome.font = UIFont.systemFont(ofSize: 40)
        //welcome.font = UIFont.boldSystemFont(ofSize: 16)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()
    
    let ademImageHolder: UIImageView = {
        let ademImage = UIImageView()
        ademImage.image = UIImage(named: "Adem Logo")
        ademImage.contentMode = .scaleAspectFit
        
        return ademImage
    }()
//    MARK: GUI Elements END -

//    MARK: - subViews instantiation START
    private func setUpButtons() {
        
        nextButton.largeNextButton.backgroundColor = UIColor.white
        nextButton.largeNextButton.setTitle("Next", for: .normal)
        nextButton.largeNextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.largeNextButton.setTitleColor(UIColor.rgb(red: 76, green: 82, blue: 111), for: .normal)
        nextButton.largeNextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextButton.largeNextButton.addTarget(self, action: #selector(handelNext), for: .touchUpInside)
        nextButton.largeNextButton.resignFirstResponder()
    }
    
    private func setUpSubviews() {
        
        setUpButtons()
        view.addSubview(scrollView)
        view.addSubview(ademImageHolder)
        view.addSubview(welcomeLabel)
        scrollView.addSubview(accountCreationViews)
        scrollView.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        ademImageHolder.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        accountCreationViews.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setuploginFieldView() {
        
        NSLayoutConstraint.activate([
        
        ademImageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
        ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        ademImageHolder.heightAnchor.constraint(equalToConstant: 145),
        
        welcomeLabel.centerXAnchor.constraint(equalTo: ademImageHolder.centerXAnchor),
        welcomeLabel.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor, constant: 5),
        welcomeLabel.widthAnchor.constraint(equalTo: ademImageHolder.widthAnchor, constant: -24),
        welcomeLabel.heightAnchor.constraint(equalToConstant: 60),
            
        scrollView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5),
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
       
        accountCreationViews.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        accountCreationViews.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
        accountCreationViews.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
        accountCreationViews.heightAnchor.constraint(equalToConstant: 265),
        
        nextButton.topAnchor.constraint(equalTo: accountCreationViews.bottomAnchor, constant: 5),
        nextButton.centerXAnchor.constraint(equalTo: accountCreationViews.centerXAnchor),
        nextButton.widthAnchor.constraint(equalTo: accountCreationViews.widthAnchor),
        nextButton.heightAnchor.constraint(equalToConstant: 50),
    
        ])
    }
//    MARK: subViews instantiation END -

}
