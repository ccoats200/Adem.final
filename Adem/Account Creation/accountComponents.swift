//
//  accountComponents.swift
//  Adem
//
//  Created by Coleman Coats on 1/2/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


//MARK: Continued info view
class continuedInfo: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
    //Email Section
    let questionPrompt: UILabel = {
        let prompt = UILabel()
        prompt.textColor = UIColor.white
        prompt.layer.cornerRadius = 5
        prompt.translatesAutoresizingMaskIntoConstraints = false
        
        return prompt
    }()
    let searchBar: UISearchBar = {
        let searchBars = UISearchBar()
        searchBars.searchBarStyle = .minimal
        searchBars.layer.cornerRadius = 5
        return searchBars
    }()
    
    let expandButton: UIButton = {
        let expand = UIButton()
        expand.backgroundColor = UIColor.blue
        expand.layer.cornerRadius = 5
        expand.translatesAutoresizingMaskIntoConstraints = false
        return expand
    }()
       
    let searchInteraction: UIView = {
        let find = UIView()
        find.backgroundColor = UIColor.white
        find.translatesAutoresizingMaskIntoConstraints = false
        find.layer.cornerRadius = 5
        find.layer.masksToBounds = true
        return find
    }()
  //common func to init our view
  private func setupView() {
    //self.backgroundColor = UIColor.white
    
    self.addSubview(questionPrompt)
    self.addSubview(searchInteraction)
    searchInteraction.addSubview(searchBar)
    searchInteraction.addSubview(expandButton)
    
    searchInteraction.translatesAutoresizingMaskIntoConstraints = false
    questionPrompt.translatesAutoresizingMaskIntoConstraints = false
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.clipsToBounds = true
    
    NSLayoutConstraint.activate([
        
    questionPrompt.topAnchor.constraint(equalTo: self.topAnchor, constant: 1),
    questionPrompt.heightAnchor.constraint(equalToConstant: 50),
    questionPrompt.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    questionPrompt.widthAnchor.constraint(equalTo: self.widthAnchor),
    
    searchInteraction.topAnchor.constraint(equalTo: questionPrompt.bottomAnchor, constant: 1),
    searchInteraction.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
    searchInteraction.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    searchInteraction.widthAnchor.constraint(equalTo: self.widthAnchor),
    
    searchBar.topAnchor.constraint(equalTo: searchInteraction.topAnchor, constant: 1),
    searchBar.bottomAnchor.constraint(equalTo: searchInteraction.bottomAnchor, constant: -1),
    searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 1),
    searchBar.widthAnchor.constraint(equalToConstant: 275),
    
    expandButton.topAnchor.constraint(equalTo: searchInteraction.topAnchor, constant: 1),
    expandButton.bottomAnchor.constraint(equalTo: searchInteraction.bottomAnchor, constant: -1),
    expandButton.leftAnchor.constraint(equalTo: searchBar.rightAnchor),
    expandButton.rightAnchor.constraint(equalTo: searchInteraction.rightAnchor, constant: -1),
        
    ])
  }
}


//MARK: Continued info view
class ageInfoView: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
    
    //Password Section
       let ageQ: UILabel = {
           let ageEntry = UILabel()
           ageEntry.text = "Are you 21?"
           ageEntry.translatesAutoresizingMaskIntoConstraints = false
           ageEntry.tag = 3
           ageEntry.textColor = UIColor.white
           
           return ageEntry
       }()
    
  
    let ageDay: UITextField = {
        let day = UITextField()
        day.attributedPlaceholder = NSAttributedString(string: "DD", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        day.textColor = UIColor.black
        day.backgroundColor = UIColor.white
        day.textAlignment = .center
        day.layer.cornerRadius = 5
        day.keyboardType = .numberPad
        day.returnKeyType = .continue
        day.tag = 0
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
        month.keyboardType = .numberPad
        month.tag = 1
        month.translatesAutoresizingMaskIntoConstraints = false
        return month
    }()
    
    let ageYear: UITextField = {
        let year = UITextField()
        year.attributedPlaceholder = NSAttributedString(string: "YYYY", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        year.textColor = UIColor.black
        year.backgroundColor = UIColor.white
        year.textAlignment = .center
        year.keyboardType = .numberPad
        year.returnKeyType = .continue
        year.layer.cornerRadius = 5
                
        year.translatesAutoresizingMaskIntoConstraints = false
        
        return year
    }()
    
   
    
    
  //common func to init our view
  private func setupView() {
    
    self.addSubview(ageQ)

    let ageStackView = UIStackView(arrangedSubviews: [ageDay, ageMonth, ageYear])
    self.addSubview(ageStackView)
    
    
    ageStackView.contentMode = .scaleAspectFit
    ageStackView.spacing = 5
    ageStackView.translatesAutoresizingMaskIntoConstraints = false
    ageStackView.clipsToBounds = true
    ageStackView.layer.masksToBounds = true
    ageStackView.distribution = .fillEqually
    ageStackView.backgroundColor = UIColor.white
    
    
    NSLayoutConstraint.activate([
        
        //Password text
        ageQ.leftAnchor.constraint(equalTo: self.leftAnchor),
        ageQ.topAnchor.constraint(equalTo: self.topAnchor),
        ageQ.widthAnchor.constraint(equalTo: self.widthAnchor),
        ageQ.heightAnchor.constraint(equalToConstant: 20),
        
        ageStackView.topAnchor.constraint(equalTo: ageQ.bottomAnchor, constant: 12),
        ageStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ageStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ageStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
    ])
  }
}
