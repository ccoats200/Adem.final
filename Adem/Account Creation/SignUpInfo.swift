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
import FirebaseFirestore


class UserInfo: UIViewController, UITextFieldDelegate {
    
    // Add a new document with a generated ID
    var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    let minimuPasswordCount = 6
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Might not need. Probably need to call this in a different way. 
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        //UserLoginInfo
        colRef = Firestore.firestore().collection("User")
        docRef = Firestore.firestore().document("\(usersInfo)")
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else { return }
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else { return }
        guard let email = emailTextField.text, !email.isEmpty || !email.contains(".com") else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
    
        
        
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
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
    
            //print(currentUser?.uid as Any)
            
        }
        //Need to create a private and public collection when they sign up. one for sensitive info one for sharing food interests.
        
        //This gets the current users uid and creates the document in the users collection with the udi as the doc number. This is promising for linking users to accounds but may need a better way.
        //db.collection("Users").document(currentUser!.uid).collection("private").document("UsersPrivateInfo").setData(dataToSave)
        db.collection("Users").document().collection("private").document("UsersPrivateInfo").setData(dataToSave) { (error) in
            
            if let error = error {
                print("Error creating documents: \(error.localizedDescription)")
            } else if self.passwordTextField.text!.count < self.minimuPasswordCount {
                
                let alert = UIAlertController(title: "Email in use", message: "This email is alread in use. ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else if self.passwordTextField.text!.count > self.minimuPasswordCount {
                
                print("Data has been Saved")
                //This breaks when you try to go to the next screen from any field other than the confirm field
                
                self.passwordTextField.resignFirstResponder()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let listController = tabBar()
                
                listController.resignFirstResponder()
                appDelegate.window?.rootViewController = listController
                appDelegate.window?.makeKeyAndVisible()
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
    
    let loginFieldView: UIView = {
        let logintextfield = UIView()
        logintextfield.backgroundColor = UIColor.clear
        logintextfield.translatesAutoresizingMaskIntoConstraints = false
        logintextfield.layer.cornerRadius = 5
        logintextfield.layer.masksToBounds = true
        return logintextfield
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
    
    //Name Section
    let firstNameTextField: UITextField = {
        let firstName = UITextField()
        firstName.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
        lastName.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
    
    //Email Section
    let emailTextField: UITextField = {
        let email = UITextField()
        email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        password.tag = 3
        password.textColor = UIColor.white
        
        return password
    }()
    
    let passwordTextSeparator: UIView = {
        let passwordSeparator = UIView()
        passwordSeparator.backgroundColor = UIColor.white
        passwordSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordSeparator
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
    
    let ademImageHolder: UIImageView = {
        let ademImage = UIImageView()
        ademImage.image = UIImage(named: "Adem Logo")
        ademImage.translatesAutoresizingMaskIntoConstraints = false
        ademImage.contentMode = .scaleAspectFit
        
        return ademImage
    }()
    
    
    func setuploginFieldView() {
        
        view.addSubview(scrollView)
        
        view.addSubview(ademImageHolder)
        view.addSubview(welcomeLabel)
        scrollView.addSubview(loginFieldView)
        scrollView.addSubview(nextButton)
        
        
        //Subviews
        loginFieldView.addSubview(firstNameTextField)
        loginFieldView.addSubview(firstNameTextSeparator)
        loginFieldView.addSubview(lastNameTextField)
        loginFieldView.addSubview(lastNameTextSeparator)
        loginFieldView.addSubview(emailTextField)
        loginFieldView.addSubview(emailTextSeparator)
        loginFieldView.addSubview(passwordTextField)
        loginFieldView.addSubview(passwordTextSeparator)
        
        
        
        
        
        NSLayoutConstraint.activate([
            
        
        ademImageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
        ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        ademImageHolder.heightAnchor.constraint(equalToConstant: 125),
        
        welcomeLabel.centerXAnchor.constraint(equalTo: ademImageHolder.centerXAnchor),
        welcomeLabel.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor, constant: 5),
        welcomeLabel.widthAnchor.constraint(equalTo: ademImageHolder.widthAnchor, constant: -24),
        welcomeLabel.heightAnchor.constraint(equalToConstant: 60),
            
        scrollView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 15),
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        loginFieldView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
        loginFieldView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        loginFieldView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
        loginFieldView.heightAnchor.constraint(equalToConstant: 300),
            
        //First name text
        firstNameTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12),
        firstNameTextField.topAnchor.constraint(equalTo: loginFieldView.topAnchor),
        firstNameTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        firstNameTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6),
        
        //First name separator
        firstNameTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor),
        firstNameTextSeparator.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor),
        firstNameTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor),
        firstNameTextSeparator.heightAnchor.constraint(equalToConstant: 1),
        
        //Last name text
        lastNameTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12),
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextSeparator.topAnchor),
        lastNameTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        lastNameTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6),
        
        //Last name separator
        lastNameTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor),
        lastNameTextSeparator.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor),
        lastNameTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor),
        lastNameTextSeparator.heightAnchor.constraint(equalToConstant: 1),
        
        //Email text
        emailTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12),
        emailTextField.topAnchor.constraint(equalTo: lastNameTextSeparator.topAnchor),
        emailTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        emailTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6),
        
        //Name separator
        emailTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor),
        emailTextSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
        emailTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor),
        emailTextSeparator.heightAnchor.constraint(equalToConstant: 1),
        
        //Password text
        passwordTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12),
        passwordTextField.topAnchor.constraint(equalTo: emailTextSeparator.topAnchor),
        passwordTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        passwordTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6),
        
        //Password separator
        passwordTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor),
        passwordTextSeparator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
        passwordTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor),
        passwordTextSeparator.heightAnchor.constraint(equalToConstant: 1),
        
        nextButton.topAnchor.constraint(equalTo: loginFieldView.bottomAnchor, constant: 5),
        nextButton.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
        nextButton.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor),
        nextButton.heightAnchor.constraint(equalToConstant: 50),
    
        ])
    }
    
    
}


