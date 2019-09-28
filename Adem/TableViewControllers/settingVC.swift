//
//  settingVC.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore

class settings: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //reuse ID's
    let privacy = "privacy"
    let cellWithSwitch = "Switchcell"
    private var settingsTableView: UITableView!
    
    let settingsOptions = ["Notifications","List view","Privacy","Security","Help","Account","About","Log out"]
    
    //MARK: Settings Table View header - Start
    var settingsCategories = ["Visual", "You", "Data"]
    var settingsSubtitles = ["List", "Images", "Data"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let setText = UILabel()
        setText.text = "Settings"
        setText.font = UIFont(name: "Lato", size: 20)
        setText.textColor = UIColor.white
        navigationItem.titleView = setText
        navigationController?.navigationBar.isTranslucent = false
        
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        settingsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        
        //editing to reorder cell
        //self.settingsTableView.isEditing = true
        settingsTableView.backgroundColor = UIColor.white
        
        //MARK: Custom Cells
        self.settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: privacy)
        self.settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellWithSwitch)

        
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
        self.view.addSubview(settingsTableView)
        
    }
    /*
    //editing to reorder cell - Start
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.settingsCategories[sourceIndexPath.row]
        settingsCategories.remove(at: sourceIndexPath.row)
        settingsCategories.insert(movedObject, at: destinationIndexPath.row)
    }
    //editing to reorder cell - End
*/
    
    //MARK: Settings Icons - START
    let settingsImage: UIImageView = {
        let settingsIcon = UIImageView()
        settingsIcon.contentMode = .scaleAspectFill
        settingsIcon.layer.masksToBounds = true
        settingsIcon.clipsToBounds = true
        settingsIcon.layer.shadowColor = UIColor.clear.cgColor
        settingsIcon.layer.borderColor = UIColor.white.cgColor
        settingsIcon.translatesAutoresizingMaskIntoConstraints = false
        
        return settingsIcon
    }()
    //MARK: Settings Icons - END
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsCategories[section]
    }
    
    //Settings Sections - Start
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsCategories.count
    }
    //Settings Sections - End
    
    
    //Settings Table View header - End
    
    //Settings Row handlers - Start
    @objc func settingsRowOne() {
        
        let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(cController, animated: true)
        
        print("Settings Tab is active")
    }
    //Settings Row handlers - End
    
    //Settings Rows and headers - Start
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return settingsOptions.count
        default:
            return 1
        }
    }
    //Settings Rows and headers - End
    
    func image( _ image: UIImage, withSize newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
    
    @objc func switchForListDesign(sender: UISwitch) {
        //changeBackground()
        
        if (sender.isOn == true) {
            
            print("User is viewing the list in list view style")
        } else {
            
            print("User is viewing the list in collection view style")
        }
        //settingsTableView.reloadData()
    }
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: x, y: y, width: width, height: height)) //set these values as necessary
        returnedView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        
        label.text = self.sectionHeaderTitleArray[section]
        returnedView.addSubview(label)
        
        return returnedView
    }
    */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingsListOptions = UITableViewCell(style: .subtitle, reuseIdentifier: self.privacy)
        
        //MARK: Cell instantiation
        
        
        let row = indexPath.row
        let section = indexPath.section
        
        
        let colorSwitch = UISwitch(frame: .zero)
        colorSwitch.isOn = false
        colorSwitch.setOn(false, animated: true)
        colorSwitch.tag = row // for detect which row switch Changed
        colorSwitch.addTarget(self, action: #selector(switchForListDesign), for: .valueChanged)

        
        settingsListOptions.textLabel?.text = settingsOptions[row]
        settingsListOptions.textLabel?.textAlignment = .left
        settingsListOptions.textLabel?.textColor = UIColor.black
        
        settingsListOptions.detailTextLabel?.textColor = UIColor.black
        settingsListOptions.detailTextLabel?.textAlignment = .left
        
        
        
        switch section {
        case 0:
            if row == 1 {
                //let cellWithSwitcher = settingsListOptions.dequeueReusableCell(withIdentifier: cellWithSwitch, for: indexPath)
                //return cellWithSwitcher
            } else {
                settingsListOptions.accessoryView = nil
                settingsListOptions.imageView?.image = image(UIImage(named: "nutritionFacts")!, withSize: CGSize(width: 40, height: 40))
                settingsListOptions.imageView?.clipsToBounds = true
                settingsListOptions.imageView?.layer.masksToBounds = true
            }
        case 1:
            settingsListOptions.accessoryView = nil
            settingsListOptions.imageView?.image = image(UIImage(named: "Pencil")!, withSize: CGSize(width: 40, height: 40))
            settingsListOptions.imageView?.clipsToBounds = true
            settingsListOptions.imageView?.layer.masksToBounds = true
        case 2:
            settingsListOptions.accessoryView = nil
            settingsListOptions.imageView?.image = image(UIImage(named: "Vegan")!, withSize: CGSize(width: 40, height: 40))
            settingsListOptions.imageView?.clipsToBounds = true
            settingsListOptions.imageView?.layer.masksToBounds = true
        default:
            settingsListOptions.accessoryView = nil
        }
        
        
        
        return settingsListOptions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellRow = indexPath.row
        let cellSection = indexPath.section
        
        switch cellRow {
        case 0:
            print("1")
        default:
            print("2")
        }
    }
}




/*
class settings: UIViewController, UITextFieldDelegate {
    
    // Add a new document with a generated ID
    var docRef: DocumentReference!
    var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    let minimuPasswordCount = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docRef = Firestore.firestore().document("\(userNames)")
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        
        view.backgroundColor = UIColor.ademGreen
        
        
        view.addSubview(loginFieldView)
        
        setuploginFieldView()
        
    }
    
    let loginFieldView: UIView = {
        let logintextfield = UIView()
        logintextfield.backgroundColor = UIColor.white
        logintextfield.translatesAutoresizingMaskIntoConstraints = false
        logintextfield.layer.cornerRadius = 5
        logintextfield.layer.borderWidth = 1
        logintextfield.layer.borderColor = UIColor.gray.cgColor
        logintextfield.layer.masksToBounds = true
        return logintextfield
    }()
    
    
    @objc func handelLogin()
    {
        
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        print(email)
        print(password)
        
        //User: Created with email
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        //let listController = listCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
        let listController = listCollectionView()
        //self.navigationController?.pushViewController(listController, animated: true)
        //self.tabBarController?.present(listController, animated: true, completion: nil)
        
        appDelegate.window?.rootViewController = listController
        appDelegate.window?.makeKeyAndVisible()
        
        print("Logging in")
    }
    
    
    
    @objc func handelSignUp()
    {
        
        /*
         print(" tapped sign up button")
         
         print(minimuPasswordCount)
         
         
         
         //guard let user = AuthDataResult?.user else { return }
         guard let email = emailTextField.text, !email.isEmpty else { return }
         guard let password = passwordTextField.text, !password.isEmpty else { return }
         
         print(email)
         print(password)
         
         Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!)
         
         let dataToSave: [String: Any] = ["Email": email, "Password": password]
         docRef.setData(dataToSave) { (error) in
         if let error = error {
         print("Error getting documents: \(error.localizedDescription)")
         } else {
         print("Data has been Saved")
         }
         }
         */
        
        
        let signUpInfo = UserInfo()
        self.present(signUpInfo, animated: true, completion: nil)
        //self.navigationController?.pushViewController(signUpInfo, animated: true)
        print("Sending user to sign up Flow")
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    let userNameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "User Name"
        name.translatesAutoresizingMaskIntoConstraints = false
        
        return name
    }()
    
    let emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let emailTextSeparator: UIView = {
        let textSeparator = UIView()
        textSeparator.backgroundColor = UIColor.lightGray
        textSeparator.translatesAutoresizingMaskIntoConstraints = false
        //textSeparator.centerXAnchor.constraint(equalTo: textSeparator.centerXAnchor).isActive = true
        //textSeparator.widthAnchor.constraint(equalTo: textSeparator.widthAnchor, constant: -24).isActive = true
        return textSeparator
    }()
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        
        return password
    }()
    
    let passwordTextSeparator: UIView = {
        let passwordSeparator = UIView()
        passwordSeparator.backgroundColor = UIColor.lightGray
        passwordSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordSeparator
    }()
    
    
    func setuploginFieldView() {
        
        
        //login Fields
        loginFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        loginFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginFieldView.heightAnchor.constraint(equalToConstant: 500).isActive = true //125 also looks good
        
        //loginFieldView.addSubview(userNameTextField)
        loginFieldView.addSubview(emailTextField)
        loginFieldView.addSubview(emailTextSeparator)
        loginFieldView.addSubview(passwordTextField)
        
        let passwordImage = UIImage(named:"Check")
        addRightImageTo(textField: emailTextField, addImage: passwordImage!)
        
        //Email text
        emailTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: loginFieldView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/2).isActive = true
        
        //Name separator
        //emailTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: -20).isActive = true
        emailTextSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailTextSeparator.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor).isActive = true
        emailTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor,  constant: -25).isActive = true
        emailTextSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //Password text
        passwordTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextSeparator.topAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/2).isActive = true
        
    }
    
    func addRightImageTo(textField: UITextField, addImage img: UIImage) {
        let rightImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        rightImageView.image = img
        textField.rightView = rightImageView
        textField.rightViewMode = .always
        
    }
    
}
*/
