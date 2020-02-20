//
//  buttons.swift
//  Adem
//
//  Created by Coleman Coats on 2/11/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Login button view
class navigationButton: UIView {
  
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
  
    let largeNextButton: UIButton = {
        let login = UIButton(type: .system)
        login.backgroundColor = UIColor.ademBlue
        login.titleLabel?.font = UIFont(name: headerFont, size: 20)
        login.layer.cornerRadius = 5
        login.setTitleColor(UIColor.white, for: .normal)
        login.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        login.layer.masksToBounds = true
        login.translatesAutoresizingMaskIntoConstraints = false

        return login
    }()
    
    
  //common func to init our view
  private func setupView() {

    self.layer.masksToBounds = true
    
    self.addSubview(largeNextButton)
    largeNextButton.translatesAutoresizingMaskIntoConstraints = false
    
    
    NSLayoutConstraint.activate([
        
        largeNextButton.topAnchor.constraint(equalTo: self.topAnchor),
        largeNextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        largeNextButton.widthAnchor.constraint(equalTo: self.widthAnchor),
        largeNextButton.heightAnchor.constraint(equalTo: self.heightAnchor)
    ])
  }
}


