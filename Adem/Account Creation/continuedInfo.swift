//
//  continuedInfo.swift
//  Adem
//
//  Created by Coleman Coats on 12/17/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore


class moreInfo: UIViewController, UITextFieldDelegate {
    
    // Add a new document with a generated ID
    var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    let minimuPasswordCount = 6
    

    //MARK: Searchview
    var searchView = continuedInfo()
    var dietField = continuedInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //UserLoginInfo
        colRef = Firestore.firestore().collection("User")
        docRef = Firestore.firestore().document("\(usersInfo)")
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        searchFoodsQ.delegate = self
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

    
    @objc func handleNext()
    {
        print("New user tapped signUp button")
        guard let firstName = searchFoodsQ.text, !firstName.isEmpty else { return }
        guard let email = allergiesQ.text, !email.isEmpty || !email.contains(".com") else { return }
        guard let password = ageQ.text, !password.isEmpty else { return }
    
        
        
        print(firstName)
        print(email)
        print(password)
        
        let dataToSave: [String: Any] = [
            "FirstName": firstName,
            "Email": email,
            "Password": password
        ]
        
        Auth.auth().createUser(withEmail: allergiesQ.text!, password: ageQ.text!) { authResult, error in
    
            //print(currentUser?.uid as Any)
            
        }
        //Need to create a private and public collection when they sign up. one for sensitive info one for sharing food interests.
        
        //This gets the current users uid and creates the document in the users collection with the udi as the doc number. This is promising for linking users to accounds but may need a better way.
        //db.collection("Users").document(currentUser!.uid).collection("private").document("UsersPrivateInfo").setData(dataToSave)
        db.collection("Users").document().collection("private").document("UsersPrivateInfo").setData(dataToSave) { (error) in
            
            if let error = error {
                print("Error creating documents: \(error.localizedDescription)")
            } else if self.ageQ.text!.count < self.minimuPasswordCount {
                
                let alert = UIAlertController(title: "Email in use", message: "This email is alread in use. ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else if self.ageQ.text!.count > self.minimuPasswordCount {
                
                print("Data has been Saved")
                //This breaks when you try to go to the next screen from any field other than the confirm field
                
                self.ageQ.resignFirstResponder()
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
    @objc func finishLaterButton() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let skipAccountCreation = tabBar()
        appDelegate.window?.rootViewController = skipAccountCreation
        print("Allowing user to skip the login or sign up flow")
    }
    
    func addLeftImageTo(textField: UITextField, addImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        leftImageView.contentMode = .scaleAspectFit
        textField.leftView = leftImageView
        textField.leftViewMode = .always
        
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
        scrolling.contentSize.height = 700
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
    let searchFoodsQ: UITextField = {
        let foods = UITextField()
        foods.attributedPlaceholder = NSAttributedString(string: "What do you like?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        foods.textColor = UIColor.white
        foods.returnKeyType = .continue
        foods.tag = 0
        foods.layer.cornerRadius = 5
        foods.translatesAutoresizingMaskIntoConstraints = false

        return foods
    }()
    
    //Email Section
    let allergiesQ: UILabel = {
        let allg = UILabel()
        allg.text = "Have any diet restrictions?"
        allg.textColor = UIColor.white
        allg.layer.cornerRadius = 15
        allg.translatesAutoresizingMaskIntoConstraints = false
        
        return allg
    }()
    
    //Password Section
    let ageQ: UILabel = {
        let ageEntry = UILabel()
        ageEntry.text = "Are you 21?"
        ageEntry.translatesAutoresizingMaskIntoConstraints = false
        ageEntry.tag = 3
        ageEntry.textColor = UIColor.white
        
        return ageEntry
    }()
    
    let ageInput: UIView = {
        let ageText = UIView()
        ageText.backgroundColor = UIColor.clear
        ageText.translatesAutoresizingMaskIntoConstraints = false
        ageText.layer.cornerRadius = 5
        return ageText
    }()
    
    let agePicker: UIDatePicker = {
       let agePick = UIDatePicker()
        agePick.datePickerMode = UIDatePicker.Mode.date

        return agePick
    }()
    
    let ageDay: UITextField = {
        let day = UITextField()
        day.attributedPlaceholder = NSAttributedString(string: "DD", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        day.textColor = UIColor.black
        day.backgroundColor = UIColor.white
        day.textAlignment = .center
        day.layer.cornerRadius = 5
        day.translatesAutoresizingMaskIntoConstraints = false
        
        return day
    }()
    
    let ageMonth: UITextField = {
        let month = UITextField()
        month.attributedPlaceholder = NSAttributedString(string: "MM", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        month.textColor = UIColor.black
        month.backgroundColor = UIColor.white
        month.textAlignment = .center
        month.layer.cornerRadius = 5
        month.translatesAutoresizingMaskIntoConstraints = false
        return month
    }()
    
    let ageYear: UITextField = {
        let year = UITextField()
        year.attributedPlaceholder = NSAttributedString(string: "YYYY", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        year.textColor = UIColor.black
        year.backgroundColor = UIColor.white
        year.textAlignment = .center
        year.layer.cornerRadius = 5
        year.translatesAutoresizingMaskIntoConstraints = false
        
        return year
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
        createAccount.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        createAccount.resignFirstResponder()
        
        return createAccount
        
    }()
    
    //MARK: Later Button
    lazy var laterButton: UIButton = {
        let finishAccountLater = UIButton(type: .system)
        finishAccountLater.backgroundColor = UIColor.white
        finishAccountLater.setTitle("Finish Later", for: .normal)
        finishAccountLater.translatesAutoresizingMaskIntoConstraints = false
        finishAccountLater.layer.cornerRadius = 5
        finishAccountLater.layer.masksToBounds = true
        finishAccountLater.setTitleColor(UIColor.rgb(red: 76, green: 82, blue: 111), for: .normal)
        finishAccountLater.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //TODO: swap selector
        finishAccountLater.addTarget(self, action: #selector(finishLaterButton), for: .touchUpInside)
        finishAccountLater.resignFirstResponder()
        
        return finishAccountLater
        
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
        scrollView.addSubview(loginFieldView)
        scrollView.addSubview(nextButton)
        scrollView.addSubview(laterButton)
        
        
        //Subviews
        loginFieldView.addSubview(searchFoodsQ)
        loginFieldView.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.searchBar.placeholder = "Favorite foods"
        searchView.layer.cornerRadius = 5
        loginFieldView.addSubview(allergiesQ)
        loginFieldView.addSubview(dietField)
        dietField.translatesAutoresizingMaskIntoConstraints = false
        dietField.searchBar.placeholder = "Allergies?"
        dietField.layer.cornerRadius = 5
        loginFieldView.addSubview(ageQ)
        loginFieldView.addSubview(ageInput)
        
        
        let ageStackView = UIStackView(arrangedSubviews: [ageDay, ageMonth, ageYear])
        ageInput.addSubview(ageStackView)
        
        ageStackView.contentMode = .scaleAspectFit
        ageStackView.spacing = 5
        //ageStackView.setCustomSpacing(40, after: whereToBuy)
        ageStackView.translatesAutoresizingMaskIntoConstraints = false
        ageStackView.clipsToBounds = true
        ageStackView.layer.masksToBounds = true
        ageStackView.distribution = .fillEqually
        ageStackView.backgroundColor = UIColor.white
        
       
        NSLayoutConstraint.activate([
            
        ademImageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
        ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        ademImageHolder.heightAnchor.constraint(equalToConstant: 145),
        
        scrollView.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor, constant: 5),
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        loginFieldView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
        loginFieldView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        loginFieldView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
        loginFieldView.heightAnchor.constraint(equalToConstant: 365),
        
        //Social Buttons
        searchFoodsQ.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
        searchFoodsQ.topAnchor.constraint(equalTo: loginFieldView.topAnchor, constant: 5),
        searchFoodsQ.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        searchFoodsQ.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6),
 
        //First name separator
        searchView.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
        searchView.topAnchor.constraint(equalTo: searchFoodsQ.bottomAnchor),
        searchView.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        searchView.heightAnchor.constraint(equalToConstant: 50),
    
            
        //Email text
        allergiesQ.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12),
        allergiesQ.topAnchor.constraint(equalTo: searchView.bottomAnchor),
        allergiesQ.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        allergiesQ.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6),
 
        //Name separator
        dietField.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
        dietField.topAnchor.constraint(equalTo: allergiesQ.bottomAnchor),
        dietField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        dietField.heightAnchor.constraint(equalToConstant: 50),
        
        //Password text
        ageQ.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12),
        ageQ.topAnchor.constraint(equalTo: dietField.bottomAnchor),
        ageQ.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        ageQ.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/6),
        
        //Password separator
        ageInput.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
        ageInput.topAnchor.constraint(equalTo: ageQ.bottomAnchor),
        ageInput.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        ageInput.heightAnchor.constraint(equalToConstant: 50),

/*
        agePicker.centerXAnchor.constraint(equalTo: ageInput.centerXAnchor),
        agePicker.centerYAnchor.constraint(equalTo: ageInput.centerYAnchor),
        agePicker.heightAnchor.constraint(equalTo: ageInput.heightAnchor),
        agePicker.widthAnchor.constraint(equalTo: ageInput.widthAnchor),
        */
        
        ageStackView.centerXAnchor.constraint(equalTo: ageInput.centerXAnchor),
        ageStackView.centerYAnchor.constraint(equalTo: ageInput.centerYAnchor),
        ageStackView.heightAnchor.constraint(equalTo: ageInput.heightAnchor),
        ageStackView.widthAnchor.constraint(equalTo: ageInput.widthAnchor),
 
        
        nextButton.topAnchor.constraint(equalTo: loginFieldView.bottomAnchor, constant: 5),
        nextButton.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
        nextButton.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24),
        nextButton.heightAnchor.constraint(equalToConstant: 50),
        
        laterButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 5),
        laterButton.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor),
        laterButton.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -200),
        laterButton.heightAnchor.constraint(equalToConstant: 50),
    
        ])
    }
}
