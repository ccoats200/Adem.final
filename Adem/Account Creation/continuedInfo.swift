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



//MARK: Might Delete... Probably Delete

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
        setUpButtons()
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
        createAccount.setTitleColor(UIColor.ademBlue, for: .normal)
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
        finishAccountLater.setTitleColor(UIColor.ademBlue, for: .normal)
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
    var preferenceView = continuedInfo()
    var dietView = continuedInfo()
    var ageView = ageInfoView()
    
    
    private func setUpSubviews() {
        
        view.addSubview(scrollView)
        
        view.addSubview(ademImageHolder)
        scrollView.addSubview(nextButton)
        scrollView.addSubview(laterButton)
        scrollView.addSubview(preferenceView)
        scrollView.addSubview(dietView)
        scrollView.addSubview(ageView)
        
        
        preferenceView.questionPrompt.text = "What do you like?"
        preferenceView.layer.cornerRadius = 5
        dietView.questionPrompt.text = "Have any allergies?"
        dietView.layer.cornerRadius = 5
        
        ageView.translatesAutoresizingMaskIntoConstraints = false
        preferenceView.translatesAutoresizingMaskIntoConstraints = false
        dietView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func tryAgain() {
        let alert = addedFoodPreference()
        //alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func changeColor() {
        
        if preferenceView.addLaterButton.backgroundColor == UIColor.ademBlue {
            preferenceView.addLaterButton.backgroundColor = UIColor.ademGreen
        } else if preferenceView.addLaterButton.backgroundColor == UIColor.ademGreen {
            preferenceView.addLaterButton.backgroundColor = UIColor.ademBlue
        }
        
        print("changed color")
    }
    
    private func setUpButtons() {
        preferenceView.addNowButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        preferenceView.addLaterButton.addTarget(self, action: #selector(changeColor), for: .touchUpInside)

        
    }
    
    private func setuploginFieldView() {
       
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
            preferenceView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            preferenceView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            preferenceView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
            preferenceView.heightAnchor.constraint(equalToConstant: 100),
            
        //Name separator
            dietView.topAnchor.constraint(equalTo: preferenceView.bottomAnchor, constant: 20),
            dietView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            dietView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
            dietView.heightAnchor.constraint(equalToConstant: 100),
        
        //Password separator
            ageView.topAnchor.constraint(equalTo: dietView.bottomAnchor, constant: 20),
            ageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            ageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24),
            ageView.heightAnchor.constraint(equalToConstant: 100),
        
        nextButton.topAnchor.constraint(equalTo: ageView.bottomAnchor, constant: 50),
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
