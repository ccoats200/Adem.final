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

class login: UIViewController, UITextFieldDelegate {
    
    /*
     Need a forgot password button.
     */
    
    //MARK: Login Views
    var userInfoCaptureElements = loginInfoView()
    var buttonsUsedToLogIn = loginButtonView()
    var maybeButton = navigationButton()
    
    //MARK: Login methods
    var facebookLoginImage = roundButtonView()
    var twitterLoginImage = roundButtonView()
    var GoogleLoginImage = roundButtonView()
    
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
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

        //MARK: This is working a little better but now it's funky in the log out
        handle = firebaseAuth.addStateDidChangeListener { (auth, user) in

            db.collection("user").document("\(user?.uid)").collection("private").document("usersPrivateData").getDocument { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else if currentUser == nil {
                    print("no current user")
                } else {
                    self.defaults.setValuesForKeys((snapshot?.data())!)
                    print(self.defaults)
                }
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseAuth.removeStateDidChangeListener(handle!)
    }
    
    func incorrectInformationAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handelLogin() {
        //Making sure that credentials are correct
        guard let email = userInfoCaptureElements.emailTextField.text else { return }
        guard let password = userInfoCaptureElements.passwordTextField.text else { return }
        
        //User: Sign in with email
        firebaseAuth.signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let strongSelf = self else { return }
            
            if let error = error as? NSError {
              switch AuthErrorCode(rawValue: error.code) {
              case .operationNotAllowed:
                // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                print("not allowed")
              case .userDisabled:
                // Error: The user account has been disabled by an administrator.
                print("disabled")
              case .missingEmail:
                self?.incorrectInformationAlert(title: "Login Failed", message: "Email missing")
              case .wrongPassword:
                // Error: The password is invalid or the user does not have a password.
                self?.incorrectInformationAlert(title: "Login Failed", message: "Password incorrect")
              case .invalidEmail:
                // Error: Indicates the email address is malformed.
                self?.incorrectInformationAlert(title: "Login Failed", message: "Email incorrect")
              case .accountExistsWithDifferentCredential:
                self?.incorrectInformationAlert(title: "Login Failed", message: "Incorrect information")
              case .emailAlreadyInUse:
                self?.incorrectInformationAlert(title: "Login Failed", message: "Email already in use")
              default:
                  print("Error: \(error.localizedDescription)")
              }
            } else {
                                
                //This may be wrong but I need to grab defaults on login if user deleted app. only the first time. don't want multiple calls to fb.
                
                //https://brainwashinc.com/2017/07/21/loading-activity-indicator-ios-swift/
                //This is working mauybe...
//                handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
//                    db.collection("user").document(user!.uid).collection("private").document("usersPrivateData").getDocument { (snapshot, err) in
//                        if let err = err {
//                            print("Error getting documents: \(err)")
//                        } else {
//                            self?.defaults.setValuesForKeys((snapshot?.data())!)
//                            print(self?.defaults)
//                        }
//                    }
//                }
                
                //Need to see if this list is accurate or showing the old list. Need to go through user defaults
                //Might need these for later
                //https://stackoverflow.com/questions/55795444/how-to-check-is-user-is-log-in-in-different-view-controllers-in-firebase/55795674
                //https://fluffy.es/how-to-transition-from-login-screen-to-tab-bar-controller/
                //https://fluffy.es/how-to-transition-from-login-screen-to-tab-bar-controller/
                
                //This needs user defaults!!!
                //https://github.com/firebase/quickstart-ios/blob/5694c29ac5a8dcc672ec13f55f0ab74a6b9af11e/authentication/LegacyAuthQuickstart/AuthenticationExampleSwift/EmailViewController.swift#L38-L85
                
                //FIXME: this isn't working now IDK why
                strongSelf.sendToListScreen()
            }
        }
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
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }

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
        print("Sending user to Facebook Flow")
    }
    
    @objc func handelGooglesignUp() {
        print("Sending user to Google Flow")
    }
    
    @objc func handelTwittersignUp() {
        
//        let signUpInfos = userCreation()
        let signUpInfos = addedDietPreferencesTwo()
        if #available(iOS 13.0, *) {
            signUpInfos.isModalInPresentation = true
            //https://developer.apple.com/documentation/uikit/uiadaptivepresentationcontrollerdelegate/3229888-presentationcontrollerdidattempt
        } else {
            // Fallback on earlier versions
        }
        self.present(signUpInfos, animated: true, completion: nil)
    }

    
    @objc func handelSignUp() {
        let signUpInfo = UserInfo()
        self.present(signUpInfo, animated: true, completion: nil)
    }
    
    @objc func handleSkip() {
        
        Auth.auth().signInAnonymously() { (authResult, error) in
          guard let user = authResult?.user else { return }
          let isAnonymous = user.isAnonymous  // true
          let uid = user.uid
            /*
        db.collection("Users").document(authResult!.user.uid).collection("private").document("UsersPrivateInfo").setData([
            "isAnonymous": isAnonymous,
            "uid": uid
            
        ]) { (error) in
            if let error = error {
                print("Error creating documents: \(error.localizedDescription)")
            }
        }
 */
            db.collection("home").document(authResult!.user.uid).collection("private").document("UsersPrivateInfo").setData([
                "isAnonymous": isAnonymous,
                "uid": uid
                
            ]) { (error) in
                if let error = error {
                    print("Error creating documents: \(error.localizedDescription)")
                }
            }
        }
        sendToListScreen()
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
        
        maybeButton.largeNextButton.setTitle("Maybe Later", for: .normal)
        maybeButton.largeNextButton.titleLabel?.font = UIFont(name: productFont, size: 12)
        maybeButton.largeNextButton.setTitleColor(UIColor.white, for: .normal)
        maybeButton.largeNextButton.backgroundColor = UIColor.clear
     }
    
    
    
    private func setupconstraints() {
 
        let differentSignUpMethodsStackView = UIStackView(arrangedSubviews: [facebookLoginImage, twitterLoginImage, GoogleLoginImage])
        differentSignUpMethodsStackView.contentMode = .scaleAspectFit
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
