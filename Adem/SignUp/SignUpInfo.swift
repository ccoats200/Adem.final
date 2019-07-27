//
//  SignUpInfo.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import Firebase
import FirebaseFirestore


class UserInfo: UIViewController, UITextFieldDelegate {
    
    // Add a new document with a generated ID
    var docRef: DocumentReference!
    var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    let minimuPasswordCount = 6
    
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        //UserLoginInfo
        docRef = Firestore.firestore().document("\(usersInfo)")
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        nextButton.resignFirstResponder()
        
        
        
        //Backgound Color Start
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.rgb(red: 59, green: 94, blue: 101).cgColor,UIColor.ademGreen.cgColor]
        //Top left
        gradient.startPoint = CGPoint(x: 0, y: 0)
        //Top right
        gradient.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(gradient)
        //Backgound Color End
        
        view.addSubview(loginFieldView)
        view.addSubview(nextButton)
        
        setuploginFieldView()
        sendToSignUpFlow()
        
    }
    
    
    let loginFieldView: UIView = {
        let logintextfield = UIView()
        logintextfield.backgroundColor = UIColor.clear
        logintextfield.translatesAutoresizingMaskIntoConstraints = false
        logintextfield.layer.cornerRadius = 5
        logintextfield.layer.masksToBounds = true
        return logintextfield
    }()
    
    
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
        
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else { return }
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else { return }
        guard let email = emailTextField.text, !email.isEmpty || !email.contains(".com") else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else { return }
        
        
        print(firstName)
        print(lastName)
        print(email)
        print(password)
        print(confirmPassword)
        
        let dataToSave: [String: Any] = [
            "FirstName": firstName,
            "LastName": lastName,
            "Email": email,
            "Password": password,
            "Confirm": confirmPassword
        ]
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            
        }
        /*
         var ref: DocumentReference? = nil
         ref = db.collection("users").addDocument(data: [
         "name": "Tokyo",
         "country": "Japan"
         ]) { err in
         if let err = err {
         print("Error adding document: \(err)")
         } else {
         print("Document added with ID: \(ref!.documentID)")
         }
         }
         
         // Add a new document in collection "cities"
         db.collection("users").addDocument(data: dataToSave) { err in
         if let err = err {
         print("Error writing document: \(err)")
         } else {
         print("Document successfully written!")
         }
         }
         */
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
    }
    
    //Accessory Views
    func addRightImageTo(textField: UITextField, addImage img: UIImage) {
        let rightImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        rightImageView.image = img
        textField.rightView = rightImageView
        textField.rightViewMode = .always
        
    }
    
    func addLeftImageTo(textField: UITextField, addImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        leftImageView.contentMode = .scaleAspectFit
        textField.leftView = leftImageView
        textField.leftViewMode = .always
        
        if passwordTextField.isEditing == true {
            return leftImageView.tintColor = UIColor.blue
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            nextButton.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    
    //Name Section
    let firstNameTextField: UITextField = {
        let firstName = UITextField()
        firstName.placeholder = "First Name"
        firstName.translatesAutoresizingMaskIntoConstraints = false
        firstName.textColor = UIColor.white
        firstName.returnKeyType = .continue
        firstName.tag = 0
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
        lastName.placeholder = "Last Name"
        lastName.translatesAutoresizingMaskIntoConstraints = false
        lastName.textColor = UIColor.white
        lastName.tag = 1
        return lastName
    }()
    
    let lastNameTextSeparator: UIView = {
        let lastTextSeparator = UIView()
        lastTextSeparator.backgroundColor = UIColor.white
        lastTextSeparator.translatesAutoresizingMaskIntoConstraints = false
        return lastTextSeparator
    }()
    
    //UserName Section
    let userNameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "User Name"
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor.white
        //name.tag = 2
        return name
    }()
    
    let userNameTextSeparator: UIView = {
        let textSeparator = UIView()
        textSeparator.backgroundColor = UIColor.white
        textSeparator.translatesAutoresizingMaskIntoConstraints = false
        return textSeparator
    }()
    
    //Email Section
    let emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.translatesAutoresizingMaskIntoConstraints = false
        email.textColor = UIColor.white
        email.tag = 2
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
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        password.tag = 3
        
        return password
    }()
    
    let passwordTextSeparator: UIView = {
        let passwordSeparator = UIView()
        passwordSeparator.backgroundColor = UIColor.white
        passwordSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordSeparator
    }()
    
    let confirmPasswordTextField: UITextField = {
        let confirmPassword = UITextField()
        confirmPassword.placeholder = "Confirm Password"
        confirmPassword.isSecureTextEntry = true
        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        confirmPassword.tag = 4
        
        return confirmPassword
    }()
    
    let confirmPasswordTextSeparator: UIView = {
        let confirmPasswordSeparator = UIView()
        confirmPasswordSeparator.backgroundColor = UIColor.white
        confirmPasswordSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        return confirmPasswordSeparator
    }()
    
    //Next Button
    lazy var nextButton: UIButton = {
        let createAccount = UIButton(type: .system)
        createAccount.backgroundColor = UIColor.white
        createAccount.setTitle("Next", for: .normal)
        createAccount.translatesAutoresizingMaskIntoConstraints = false
        createAccount.layer.cornerRadius = 5
        createAccount.layer.masksToBounds = true
        createAccount.setTitleColor(UIColor.rgb(red: 76, green: 82, blue: 111), for: .normal)
        createAccount.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        createAccount.addTarget(self, action: #selector(handelNext), for: .touchUpInside)
        createAccount.resignFirstResponder()
        
        return createAccount
        
    }()
    
    
    
    func setuploginFieldView() {
        loginFieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        loginFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginFieldView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        
        
        
        //Right Images for Textfields
        let passwordImage = UIImage(named:"lock")
        addLeftImageTo(textField: passwordTextField, addImage: passwordImage!)
        let confirmPasswordImage = UIImage(named:"lock")
        addLeftImageTo(textField: confirmPasswordTextField, addImage: confirmPasswordImage!)
        
        //Left Images for Textfields
        
        let firstNameImage = UIImage(named:"AccountIcon")
        addLeftImageTo(textField: firstNameTextField, addImage: firstNameImage!)
        let lastNameImage = UIImage(named:"AccountIcon")
        addLeftImageTo(textField: lastNameTextField, addImage: lastNameImage!)
        
        
        
        //Subviews
        loginFieldView.addSubview(firstNameTextField)
        loginFieldView.addSubview(firstNameTextSeparator)
        loginFieldView.addSubview(lastNameTextField)
        loginFieldView.addSubview(lastNameTextSeparator)
        loginFieldView.addSubview(emailTextField)
        loginFieldView.addSubview(emailTextSeparator)
        loginFieldView.addSubview(passwordTextField)
        loginFieldView.addSubview(passwordTextSeparator)
        loginFieldView.addSubview(confirmPasswordTextField)
        loginFieldView.addSubview(confirmPasswordTextSeparator)
        
        
        //First name text
        firstNameTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: loginFieldView.topAnchor).isActive = true
        firstNameTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24).isActive = true
        firstNameTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6).isActive = true
        //First name separator
        firstNameTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor).isActive = true
        firstNameTextSeparator.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor).isActive = true
        firstNameTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor).isActive = true
        firstNameTextSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //Last name text
        lastNameTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12).isActive = true
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextSeparator.topAnchor).isActive = true
        lastNameTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24).isActive = true
        lastNameTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6).isActive = true
        //Last name separator
        lastNameTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor).isActive = true
        lastNameTextSeparator.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor).isActive = true
        lastNameTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor).isActive = true
        lastNameTextSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //Email text
        emailTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: lastNameTextSeparator.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6).isActive = true
        //Name separator
        emailTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor).isActive = true
        emailTextSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor).isActive = true
        emailTextSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //Password text
        passwordTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextSeparator.topAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6).isActive = true
        //Password separator
        passwordTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor).isActive = true
        passwordTextSeparator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor).isActive = true
        passwordTextSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //Confirm Password text
        confirmPasswordTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12).isActive = true
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextSeparator.topAnchor).isActive = true
        confirmPasswordTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6).isActive = true
        //Confirm Password separator
        confirmPasswordTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor).isActive = true
        confirmPasswordTextSeparator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        confirmPasswordTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor).isActive = true
        confirmPasswordTextSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    
    func sendToSignUpFlow() {
        nextButton.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: loginFieldView.bottomAnchor, constant: 12).isActive = true
        nextButton.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}


