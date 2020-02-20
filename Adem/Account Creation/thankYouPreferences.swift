//
//  thankYouPreferences.swift
//  Adem
//
//  Created by Coleman Coats on 2/10/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class thankYouPreferences: UIViewController {

    var currentViewControllerIndex = 0

    //MARK: Element calls
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        
        setUpSubviews()
        setuplayoutConstraints()
    }
    
    
    
    //Name Section
    let welcomeLabel: UILabel = {
        var welcome = UILabel()
        welcome.text = "Welcome to Adem!"
        welcome.textAlignment = .center
        welcome.numberOfLines = 0
        welcome.textColor = UIColor.ademBlue
        welcome.font = UIFont(name: helNeu, size: 20.0)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        
        return welcome
    }()
    
    let textFieldSeparator: UIView = {
        let textSeparator = UIView()
        textSeparator.backgroundColor = UIColor.ademBlue
        textSeparator.translatesAutoresizingMaskIntoConstraints = false
        return textSeparator
    }()
    
    let ademImageHolder: UIImageView = {
        let ademImage = UIImageView()
        ademImage.image = UIImage(named: "Adem Logo")
        //ademImage.image = UIImage(named: "ademSignUp")
        ademImage.backgroundColor = UIColor.red
        ademImage.layer.cornerRadius = 10
        ademImage.contentMode = .scaleAspectFit
        
        return ademImage
    }()
    
    //Name Section
    let subText: UILabel = {
        var subtext = UILabel()
        subtext.text = "We're adding your preferences so that we can give you the best experience!"
        subtext.textAlignment = .center
        subtext.numberOfLines = 0
        subtext.textColor = UIColor.ademBlue
        subtext.font = UIFont(name: helNeu, size: 20.0)
        subtext.translatesAutoresizingMaskIntoConstraints = false
        
        return subtext
    }()

    
    override func viewWillAppear(_ animated: Bool) {

    }

    private func setUpSubviews() {
        
        //MARK: subviews
        view.addSubview(welcomeLabel)
        view.addSubview(textFieldSeparator)
        view.addSubview(ademImageHolder)
        view.addSubview(subText)
        

        //TODO: this should be a loading or animation to indicate saving
//        welcomeLabel.layer.borderWidth = 2
//        welcomeLabel.layer.borderColor = UIColor.ademGreen.cgColor
//        welcomeLabel.layer.cornerRadius = 75
        
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false
        ademImageHolder.translatesAutoresizingMaskIntoConstraints = false
        subText.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func setuplayoutConstraints() {
        
           NSLayoutConstraint.activate([
            
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            
            textFieldSeparator.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            textFieldSeparator.heightAnchor.constraint(equalToConstant: 1),
            textFieldSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldSeparator.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            
            ademImageHolder.topAnchor.constraint(equalTo: textFieldSeparator.bottomAnchor, constant: 50),
            ademImageHolder.heightAnchor.constraint(equalToConstant: 150),
            ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            
            subText.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor),
            subText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            subText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subText.widthAnchor.constraint(equalTo: view.widthAnchor, constant:  -25),
            
        ])
    }
    
}
