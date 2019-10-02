//
//  imageText.swift
//  Adem
//
//  Created by Coleman Coats on 9/30/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import FirebaseMLVision

struct ImageDisplay {
    let file: String
    let name: String
}

class imageToText: UIViewController {
    var textRecognizer : VisionTextRecognizer!
    var frameSublayer = CALayer()
    
    
    override func viewDidLoad() {
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
        
        
    }
}
