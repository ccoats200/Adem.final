//
//  accountStats.swift
//  Adem
//
//  Created by Coleman Coats on 2/19/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Login button view
class statsElements: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    self.layer.masksToBounds = true
    self.backgroundColor = UIColor.ademGreen
    
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
    
  }
    

    
    let statsHolder: UIView = {
        let stats = UIView()
        stats.backgroundColor = UIColor.blue
        return stats
        }()
       
    
  //common func to init our view
  private func setupView() {
    
    self.addSubview(statsHolder)
    
    statsHolder.translatesAutoresizingMaskIntoConstraints = false

    
    NSLayoutConstraint.activate([
    
        statsHolder.heightAnchor.constraint(equalToConstant: 50),
        statsHolder.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
        statsHolder.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        statsHolder.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    ])
  }
}

