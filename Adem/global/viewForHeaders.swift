//
//  viewForHeaders.swift
//  Adem
//
//  Created by Coleman Coats on 2/27/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Login text fields view
class tableViewHeader: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
   
    //emailTextField.delegate = self
    //passwordTextField.delegate = self
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }
  
    let title: UILabel = {
        let email = UILabel()
        email.text = "Breakfast"
        email.font = UIFont(name: hNBold, size: 20)
        email.textColor = UIColor.black
        email.translatesAutoresizingMaskIntoConstraints = false
        
        return email
       }()


  //common func to init our view
  private func setupView() {
    
    self.backgroundColor = UIColor.clear
    
    self.addSubview(title)
    
    title.translatesAutoresizingMaskIntoConstraints = false

    
    NSLayoutConstraint.activate([
        
        title.topAnchor.constraint(equalTo: self.topAnchor),
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        title.widthAnchor.constraint(equalTo: self.widthAnchor, constant:  -24),
        title.heightAnchor.constraint(equalToConstant: 50),
    ])
  }
}

