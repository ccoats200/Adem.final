//
//  viewController.swift
//  Adem
//
//  Created by Coleman Coats on 7/13/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func sendToLogIn() {
   
        let loginvc = login()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginvc
        appDelegate.window?.makeKeyAndVisible()
    }
    
    func sendToListScreen() {
    
        let listController = tabBar()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = listController
        appDelegate.window?.makeKeyAndVisible()
        }
    
    func changeRootViewControllerAny(_ vc: UIViewController, animated: Bool = true) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let window = appDelegate.window else {
            return
        }
        window.rootViewController = vc
        appDelegate.window?.makeKeyAndVisible()
    }
    
}
