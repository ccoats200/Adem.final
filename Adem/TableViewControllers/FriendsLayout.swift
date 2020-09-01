//
//  FriendsLayout.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
//import FirebaseFirestore


struct friendsListInfo {
    let image: UIImage?
    let name: String?
    let title: String?
}

class friendsTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = [friendsListInfo]()
    
    private var likedMealsTableView: UITableView!
    //reuse ID's
    let privacy = "privacy"
    let cellHeight = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseLikedMealFetch()
        

        //FIXME: This is cutting off the top of the user image

        //let setText = UILabel()
        navigationItem.title = "Liked Meals"
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            //navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.ademBlue
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.tintColor = UIColor.white
        } else {
            //Something else
            print("something is wrong")
        }
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        likedMealsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        self.likedMealsTableView.separatorStyle = .none
        likedMealsTableView.backgroundColor = UIColor.white
        self.likedMealsTableView.register(customMealViewCell.self, forCellReuseIdentifier: privacy)
        
        
        self.likedMealsTableView.dataSource = self
        self.likedMealsTableView.delegate = self
        self.view.addSubview(likedMealsTableView)
        
    }
   
    func firebaseLikedMealFetch() {
        //finds one meal! see Products.swift for other ones
        userfirebaseMeals.whereField("likedMeal", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            arrayofLikedMeals = documents.compactMap { queryDocumentSnapshot -> mealClass? in
                return try? queryDocumentSnapshot.data(as: mealClass.self)
            }
            self.likedMealsTableView.reloadData()
        }
        
    }
    
    /*
    //Header Testing
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            let closeFriends = "Kitchen Staff"
            return closeFriends
        default:
            let allOther = "Friends"
            return allOther
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = 40
        
        return CGFloat(height)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    */
    //product Button
    @objc func inspectingFriend() {
        
        print("Settings Tab is active")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(arrayofLikedMeals.count)
        return arrayofLikedMeals.count
        //return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let privacy = tableView.dequeueReusableCell(withIdentifier: self.privacy, for: indexPath) as! customMealViewCell
        privacy.friendName = arrayofLikedMeals[indexPath.row].mealName.capitalized
        privacy.friendImage = UIImage(named: "\(arrayofLikedMeals[indexPath.row].mealImage)")
        
        return privacy
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    weak var cellDelegate: CustomCollectionCellDelegate?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let privacy = tableView.cellForRow(at: indexPath) as? customTableViewCell
//        
//        self.cellDelegate?.tableView(TableCell: self, IndexPath: indexPath)
        inspectingFriend()
    }
}
extension friendsTVC: CustomTableCellDelegate {
    func tableView(TableCell: UITableViewCell?, IndexPath: IndexPath) {
         
        let selectedMeal: mealClass!
        selectedMeal = likedMeal(forIndexPath: IndexPath)
             
        let detail = mealVCLayout.detailViewControllerForProduct(selectedMeal)
                        
        self.present(detail, animated: true, completion: nil)
    }
    
    
    func likedMeal(forIndexPath: IndexPath) -> mealClass {
        var product: mealClass!
        product = arrayofLikedMeals[forIndexPath.row]
        return product
    }
}


class customTableViewCell: UITableViewCell {
    
    var friendName: String?
    var friendImage: UIImage?
    var friendTitle: String?
    
    //UIView Profile Pic
    let friendsPicture: UIImageView = {
        let picOfFriend = UIImageView()
        picOfFriend.contentMode = .scaleAspectFill
        picOfFriend.layer.cornerRadius = 15
        picOfFriend.layer.masksToBounds = true
        picOfFriend.clipsToBounds = true
        picOfFriend.layer.shadowColor = UIColor.clear.cgColor
        picOfFriend.layer.borderColor = UIColor.white.cgColor
        picOfFriend.translatesAutoresizingMaskIntoConstraints = false
        
        return picOfFriend
    }()
    
    let friendsName: UILabel = {
        let nameOfFriend = UILabel()
        nameOfFriend.textAlignment = .left
        nameOfFriend.numberOfLines = 1
        nameOfFriend.adjustsFontSizeToFitWidth = true
        //userName.font = UIFont(name: "Lato", size: 80)
        nameOfFriend.font = UIFont.boldSystemFont(ofSize: 20)
        nameOfFriend.textColor = UIColor.ademBlue
        //nameOfFriend.backgroundColor = UIColor.blue
        //userName.text = "Coleman"
        nameOfFriend.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return nameOfFriend
    }()
    
    let friendsTitle: UILabel = {
        let access = UILabel()
        access.textAlignment = .left
        access.numberOfLines = 1
        access.adjustsFontSizeToFitWidth = true
        //userName.font = UIFont(name: "Lato", size: 80)
        access.font = UIFont.boldSystemFont(ofSize: 10)
        access.textColor = UIColor.ademBlue
        //access.backgroundColor = UIColor.red
        access.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return access
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //self.layer.cornerRadius = 5

        self.addSubview(friendsName)
        self.addSubview(friendsPicture)
        self.addSubview(friendsTitle)
        
        NSLayoutConstraint.activate([
            
            friendsPicture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            friendsPicture.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            friendsPicture.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendsPicture.heightAnchor.constraint(equalToConstant: 50),
            friendsPicture.widthAnchor.constraint(equalToConstant: 50),
            friendsName.leadingAnchor.constraint(equalTo: friendsPicture.trailingAnchor, constant: 15),
            friendsName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            friendsName.bottomAnchor.constraint(equalTo: friendsTitle.topAnchor, constant: -10),
            friendsName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendsTitle.leftAnchor.constraint(equalTo: friendsName.leftAnchor),
            friendsTitle.topAnchor.constraint(equalTo: friendsName.bottomAnchor),
            //friendsTitle.heightAnchor.constraint(equalToConstant: 10),
            friendsTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            friendsTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = friendName {
            friendsName.text = message
        }
        if let image = friendImage {
            friendsPicture.image = image
        }
        if let title = friendTitle {
            friendsTitle.text = title
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class customMealViewCell: UITableViewCell {
    
    var friendName: String?
    var friendImage: UIImage?
    
    //UIView Profile Pic
    let friendsPicture: UIImageView = {
        let picOfFriend = UIImageView()
        picOfFriend.contentMode = .scaleAspectFill
        picOfFriend.layer.cornerRadius = 15
        picOfFriend.layer.masksToBounds = true
        picOfFriend.clipsToBounds = true
        picOfFriend.layer.shadowColor = UIColor.clear.cgColor
        picOfFriend.layer.borderColor = UIColor.white.cgColor
        picOfFriend.translatesAutoresizingMaskIntoConstraints = false
        
        return picOfFriend
    }()
    
    let friendsName: UILabel = {
        let nameOfMeal = UILabel()
        nameOfMeal.textAlignment = .left
        nameOfMeal.numberOfLines = 1
        nameOfMeal.adjustsFontSizeToFitWidth = true
        //userName.font = UIFont(name: "Lato", size: 80)
        nameOfMeal.font = UIFont.boldSystemFont(ofSize: 20)
        nameOfMeal.textColor = UIColor.ademBlue
        
        nameOfMeal.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return nameOfMeal
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //self.layer.cornerRadius = 5

        self.addSubview(friendsName)
        self.addSubview(friendsPicture)
        
        NSLayoutConstraint.activate([
            
            friendsPicture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            friendsPicture.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            friendsPicture.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendsPicture.heightAnchor.constraint(equalToConstant: 50),
            friendsPicture.widthAnchor.constraint(equalToConstant: 50),
            friendsName.leadingAnchor.constraint(equalTo: friendsPicture.trailingAnchor, constant: 15),
            friendsName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            friendsName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            friendsName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = friendName {
            friendsName.text = message
        }
        if let image = friendImage {
            friendsPicture.image = image
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

