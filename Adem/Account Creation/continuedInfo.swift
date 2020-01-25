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


class moreInfo: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    // Add a new document with a generated ID
    var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    let minimuPasswordCount = 6
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //UserLoginInfo
        colRef = Firestore.firestore().collection("User")
        docRef = Firestore.firestore().document("\(usersInfo)")
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        //searchFoodsQ.delegate = self
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

    
    @objc func handleNext()
    {
       
                //self.ageQ.resignFirstResponder()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let listController = tabBar()
                
                listController.resignFirstResponder()
                appDelegate.window?.rootViewController = listController
                appDelegate.window?.makeKeyAndVisible()
                print("Brought to next Screen")
    }
    
    @objc func finishLaterButton() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let skipAccountCreation = tabBar()
        appDelegate.window?.rootViewController = skipAccountCreation
        print("Allowing user to skip the login or sign up flow")
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: (textField.superview?.frame.origin.y)!), animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    //MARK: Searchview
    var searchView = continuedInfo()
    var dietField = continuedInfo()
    var ageQQ = ageInfoView()
    
    
    private func setUpSubviews() {
        
        view.addSubview(scrollView)
        
        view.addSubview(ademImageHolder)
        scrollView.addSubview(nextButton)
        scrollView.addSubview(laterButton)
        scrollView.addSubview(searchView)
        scrollView.addSubview(dietField)
        scrollView.addSubview(ageQQ)
        
        
        searchView.questionPrompt.text = "What do you like?"
        searchView.searchBar.placeholder = "Favorite foods"
        searchView.layer.cornerRadius = 5
        dietField.searchBar.placeholder = "Allergies?"
        dietField.questionPrompt.text = "Have any allergies?"
        dietField.layer.cornerRadius = 5
        
        ageQQ.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false
        dietField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setuploginFieldView() {
       
        NSLayoutConstraint.activate([
            
        ademImageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
        ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        ademImageHolder.heightAnchor.constraint(equalToConstant: 145),
        
        scrollView.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor, constant: 5),
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        //First name separator
        searchView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        searchView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        searchView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
        searchView.heightAnchor.constraint(equalToConstant: 100),
            
        //Name separator
        dietField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        dietField.topAnchor.constraint(equalTo: searchView.bottomAnchor),
        dietField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
        dietField.heightAnchor.constraint(equalToConstant: 100),
        
        //Password separator
        ageQQ.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ageQQ.topAnchor.constraint(equalTo: dietField.bottomAnchor, constant: 5),
        ageQQ.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
        ageQQ.heightAnchor.constraint(equalToConstant: 100),
        
        nextButton.topAnchor.constraint(equalTo: ageQQ.bottomAnchor, constant: 50),
        nextButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        nextButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
        nextButton.heightAnchor.constraint(equalToConstant: 50),
        
        laterButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 5),
        laterButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        laterButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -200),
        laterButton.heightAnchor.constraint(equalToConstant: 50),
    
        ])
    }
}
