//
//  accountComponents.swift
//  Adem
//
//  Created by Coleman Coats on 1/2/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


 //MARK: ItemCellLayout
 /*
//List Delete protocol
protocol preferencesDelegate: class {
    func delete(cell: itemCellLayout)
    func addToList(cell: itemCellLayout)
}
*/

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
        prompt.translatesAutoresizingMaskIntoConstraints = false
        
        return prompt
    }()
    let addNowButton: UIButton = {
        let searchBars = UIButton()
        searchBars.backgroundColor = UIColor.ademBlue
        searchBars.layer.cornerRadius = 5
        searchBars.setTitle("Add now!", for: .normal)
        searchBars.setTitleColor(UIColor.white, for: .normal)
        searchBars.translatesAutoresizingMaskIntoConstraints = false
        return searchBars
    }()
    

    
    let addLaterButton: UIButton = {
        let expand = UIButton()
        expand.backgroundColor = UIColor.ademBlue
        expand.layer.cornerRadius = 5
        expand.setTitle("Maybe Later", for: .normal)
        expand.setTitleColor(UIColor.white, for: .normal)
        expand.translatesAutoresizingMaskIntoConstraints = false
        return expand
    }()
       
    let searchHolderView: UIView = {
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
    self.addSubview(searchHolderView)
    
    searchHolderView.translatesAutoresizingMaskIntoConstraints = false
    questionPrompt.translatesAutoresizingMaskIntoConstraints = false
    
    let ageStackView = UIStackView(arrangedSubviews: [addNowButton, addLaterButton])
    searchHolderView.addSubview(ageStackView)
    
    
    ageStackView.contentMode = .scaleAspectFit
    ageStackView.spacing = 15
    ageStackView.translatesAutoresizingMaskIntoConstraints = false
    ageStackView.clipsToBounds = true
    ageStackView.layer.masksToBounds = true
    ageStackView.distribution = .fillEqually
    ageStackView.backgroundColor = UIColor.white
    
    NSLayoutConstraint.activate([
        
    questionPrompt.topAnchor.constraint(equalTo: self.topAnchor),
    questionPrompt.heightAnchor.constraint(equalToConstant: 25),
    questionPrompt.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    questionPrompt.widthAnchor.constraint(equalTo: self.widthAnchor),
    
    searchHolderView.topAnchor.constraint(equalTo: questionPrompt.bottomAnchor, constant: 5),
    searchHolderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    searchHolderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    searchHolderView.widthAnchor.constraint(equalTo: self.widthAnchor),
    
    ageStackView.centerYAnchor.constraint(equalTo: searchHolderView.centerYAnchor),
    ageStackView.centerXAnchor.constraint(equalTo: searchHolderView.centerXAnchor),
    ageStackView.widthAnchor.constraint(equalTo: searchHolderView.widthAnchor, constant: -25),
    ageStackView.widthAnchor.constraint(equalTo: searchHolderView.widthAnchor, constant: -25),
    ageStackView.heightAnchor.constraint(equalTo: searchHolderView.heightAnchor, constant: -25),
    
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
