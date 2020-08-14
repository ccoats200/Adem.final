//
//  emptyList.swift
//  Adem
//
//  Created by Coleman Coats on 8/14/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


class emptyList: UIView {
    
    //MARK: Login methods
    var GoogleLoginImage = roundButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: Setting up views
        setUpSubviews()
        
    }
    
    //Authentication State listner
   required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        self.addSubview(GoogleLoginImage)
        GoogleLoginImage.backgroundColor = UIColor.gray
        GoogleLoginImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          
            GoogleLoginImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            GoogleLoginImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            GoogleLoginImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            GoogleLoginImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 4/10),
        ])
    }
}


