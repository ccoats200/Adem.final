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
//import FirebaseFirestore


class UserInfo: UIViewController, UITextFieldDelegate {
    
    // Add a new document with a generated ID
    var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    let minimuPasswordCount = 6
    

    //MARK: setUpViews
    var accountCreationViews = userCreationInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //UserLoginInfo
        colRef = Firestore.firestore().collection("User")
        docRef = Firestore.firestore().document("\(usersInfo)")
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        nextButton.resignFirstResponder()

        //Backgound Color Start
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.ademBlue.cgColor,UIColor.ademGreen.cgColor]
        //Top left
        gradient.startPoint = CGPoint(x: 0, y: 0)
        //Top right
        gradient.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(gradient)
        //Backgound Color End
        
        
        //MARK: function Calls for views
        setUpSubviews()
        setuploginFieldView()
        
    }

    
    //Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, User) in
            
            if let user = self.user {
                let name = user.displayName
                let photoURL = user.photoURL
                let uid = user.uid
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    

    
    
    @objc func handelNext()
    {
        print("New user tapped signUp button")
        guard let firstName = accountCreationViews.firstNameTextField.text, !firstName.isEmpty else { return }
        guard let lastName = accountCreationViews.lastNameTextField.text, !lastName.isEmpty else { return }
        guard let email = accountCreationViews.emailTextField.text, !email.isEmpty || !email.contains(".com") else { return }
        guard let password = accountCreationViews.passwordTextField.text, !password.isEmpty else { return }
    
        
        
        print(firstName)
        print(lastName)
        print(email)
        print(password)
        
        let dataToSave: [String: Any] = [
            "FirstName": firstName,
            "LastName": lastName,
            "Email": email,
            "Password": password
        ]
        
        Auth.auth().createUser(withEmail: accountCreationViews.emailTextField.text!, password: accountCreationViews.passwordTextField.text!) { authResult, error in
    
            //print(currentUser?.uid as Any)
            
        }
        //Need to create a private and public collection when they sign up. one for sensitive info one for sharing food interests.
        
        //This gets the current users uid and creates the document in the users collection with the udi as the doc number. This is promising for linking users to accounds but may need a better way.
        //db.collection("Users").document(currentUser!.uid).collection("private").document("UsersPrivateInfo").setData(dataToSave)
        db.collection("Users").document().collection("private").document("UsersPrivateInfo").setData(dataToSave) { (error) in
            
            if let error = error {
                print("Error creating documents: \(error.localizedDescription)")
            } else if self.accountCreationViews.passwordTextField.text!.count < self.minimuPasswordCount {
                
                let alert = UIAlertController(title: "Email in use", message: "This email is alread in use. ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else if self.accountCreationViews.passwordTextField.text!.count > self.minimuPasswordCount {
                
                print("Data has been Saved")
                //This breaks when you try to go to the next screen from any field other than the confirm field
                
                self.accountCreationViews.passwordTextField.resignFirstResponder()
                
                //let moreController = addedFoodPreference()
                let moreController = userFlowViewControllerTwo()
                moreController.resignFirstResponder()
                self.present(moreController, animated: true, completion: nil)
                
                print("Brought to next Screen")
            }
        }
        
        
        /*
        docRef.setData(dataToSave) { (error) in
            
            if let error = error {
                print("Error creating documents: \(error.localizedDescription)")
            } else if self.passwordTextField.text != self.confirmPasswordTextField.text {
                
                let alert = UIAlertController(title: "Email in use", message: "This email is alread in use. ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else if self.passwordTextField.text == self.confirmPasswordTextField.text {
                
                print("Data has been Saved")
                //This breaks when you try to go to the next screen from any field other than the confirm field
                
                self.confirmPasswordTextField.resignFirstResponder()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let listController = tabBar()
                
                listController.resignFirstResponder()
                appDelegate.window?.rootViewController = listController
                appDelegate.window?.makeKeyAndVisible()
                print("Brought to next Screen")
            }
        }
 */
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            nextButton.resignFirstResponder()
        }
        // Do not add a line break
        print(textField.tag)
        return false
    }
    
    let scrollView: UIScrollView = {
        let scrolling = UIScrollView()
        scrolling.backgroundColor = UIColor.clear
        scrolling.translatesAutoresizingMaskIntoConstraints = false
        //scrolling.contentSize.height = 500
        //scrolling.layer.masksToBounds = true
        return scrolling
    }()
    
    //Name Section
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
    
    var nextButton = navigationButton()
    
    private func setUpButtons() {
        
        nextButton.largeNextButton.backgroundColor = UIColor.white
        nextButton.largeNextButton.setTitle("Next", for: .normal)
        nextButton.largeNextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.largeNextButton.setTitleColor(UIColor.rgb(red: 76, green: 82, blue: 111), for: .normal)
        nextButton.largeNextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextButton.largeNextButton.addTarget(self, action: #selector(handelNext), for: .touchUpInside)
        nextButton.largeNextButton.resignFirstResponder()
    }
    
    let ademImageHolder: UIImageView = {
        let ademImage = UIImageView()
        ademImage.image = UIImage(named: "Adem Logo")
        ademImage.contentMode = .scaleAspectFit
        
        return ademImage
    }()
    
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
}
