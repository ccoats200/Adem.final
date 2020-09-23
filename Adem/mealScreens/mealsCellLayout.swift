//
//  mealsCellLayout.swift
//  Adem
//
//  Created by Coleman Coats on 8/12/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseFirestore

//List Delete protocol
protocol mealsItemDelegate: class {
    func delete(cell: mealsCellLayout)
    func addToList(cell: mealsCellLayout)
}

//Pantry Product Cell layout
class mealsCellLayout: UICollectionViewCell {
    
    
    weak var delegate: mealsItemDelegate?
    var eachCell: UIViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.white
        setupViews()
        
    }
    
    @objc func selectedButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    let mealImageView: UIImageView = {
        let mealImage = UIImageView()
        mealImage.contentMode = .scaleAspectFill
        mealImage.layer.cornerRadius = 5
        mealImage.clipsToBounds = true
        mealImage.layer.masksToBounds = true
        mealImage.translatesAutoresizingMaskIntoConstraints = false
        return mealImage
    }()
    
    let mealName: UILabel = {
        let mealName = UILabel()
        mealName.textAlignment = .left
        mealName.numberOfLines = 0
        mealName.font = UIFont(name: helNeu, size: 20)
        mealName.adjustsFontSizeToFitWidth = true
        mealName.translatesAutoresizingMaskIntoConstraints = false
        return mealName
    }()

    //Delete now editing button
    let favoriteButton: UIButton = {
        let fave = UIButton()
        fave.setBackgroundImage(UIImage(named: "fave-1"), for: .normal)
        //fave.setBackgroundImage(UIImage(named: "veganIcon"), for: .highlighted)
        fave.clipsToBounds = true
        fave.layer.masksToBounds = true
        fave.translatesAutoresizingMaskIntoConstraints = false
        return fave
    }()
    
    let emptyStarButton: UIImageView = UIImageView(image: UIImage(named: "star"))
    let halfStarButton: UIImageView = UIImageView(image: UIImage(named: "star_half"))
    let fullStarButton: UIImageView = UIImageView(image: UIImage(named: "star_filled"))
    let fullStarButton1: UIImageView = UIImageView(image: UIImage(named: "star_filled"))
    let fullStarButton2: UIImageView = UIImageView(image: UIImage(named: "star_filled"))
    
    let starButton1: UIButton = {
        let star = UIButton()
        star.setBackgroundImage(UIImage(named: "star"), for: .normal)
        star.clipsToBounds = true
        star.layer.masksToBounds = true
        star.translatesAutoresizingMaskIntoConstraints = false
        return star
    }()
    
    let ratingsCount: UILabel = {
        let rating = UILabel()
        rating.textAlignment = .left
        rating.text = "(10)"
        rating.numberOfLines = 0
        rating.adjustsFontSizeToFitWidth = true
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    func setupViews() {
        
        let starStack = UIStackView(arrangedSubviews: [fullStarButton,fullStarButton1,fullStarButton2,halfStarButton,emptyStarButton])
        
        starStack.spacing = 5
        starStack.clipsToBounds = true
        starStack.layer.masksToBounds = true
        starStack.distribution = .fillProportionally
        starStack.backgroundColor = UIColor.white
        
        
        self.addSubview(mealImageView)
        self.addSubview(mealName)
        self.addSubview(favoriteButton)
        self.addSubview(ratingsCount)
        self.addSubview(starStack)
        
        starStack.translatesAutoresizingMaskIntoConstraints = false
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealName.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        ratingsCount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            mealImageView.topAnchor.constraint(equalTo: self.topAnchor),
            mealImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mealImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mealImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 7/10),
            
            
            mealName.topAnchor.constraint(equalTo: mealImageView.bottomAnchor),
            mealName.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor),
            mealName.leftAnchor.constraint(equalTo: mealImageView.leftAnchor, constant: 5),
            mealName.bottomAnchor.constraint(equalTo: ratingsCount.topAnchor),
            
            favoriteButton.centerYAnchor.constraint(equalTo: mealName.centerYAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: mealImageView.rightAnchor, constant: -5),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            
            starStack.leftAnchor.constraint(equalTo: mealName.leftAnchor),
            starStack.heightAnchor.constraint(equalToConstant: 20),
            starStack.widthAnchor.constraint(equalToConstant: 125),
            starStack.bottomAnchor.constraint(equalTo: ratingsCount.bottomAnchor),
            
            ratingsCount.leftAnchor.constraint(equalTo: starStack.rightAnchor, constant: 5),
            ratingsCount.heightAnchor.constraint(equalToConstant: 20),
            ratingsCount.rightAnchor.constraint(equalTo: self.rightAnchor),
            ratingsCount.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class mealsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Think this is where I need to fetch everything
    
    var selectedGroceryItems = [groceryItemCellContent]()
    var selectedCells = [UICollectionViewCell]()
    
    var groceriesSelected = [String]()
    var mealsList: mealClass!
    
    //collection view setup
    var mealsCollectionView: UICollectionView!
    let mealsCellID = "meals"
    let mealsCCellID = "Cmeals"
    
    
    //weak var cellDelegate: CustomCollectionCellDelegate?
    var cellDelegate: CustomCollectionCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        firebaseMealFetch()
        
        let mealsCollectionViewlayouts = UICollectionViewFlowLayout()
        mealsCollectionViewlayouts.scrollDirection = .horizontal
        mealsCollectionViewlayouts.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
        
        
        
        self.mealsCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout:  mealsCollectionViewlayouts)
        
        
        if #available(iOS 13.0, *) {
            self.mealsCollectionView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        
        mealsCollectionView.showsHorizontalScrollIndicator = false
        self.mealsCollectionView.dataSource = self
        self.mealsCollectionView.delegate = self
        self.mealsCollectionView.register(mealsCellLayout.self, forCellWithReuseIdentifier: mealsCCellID)
        self.mealsCollectionView.isUserInteractionEnabled = true
        self.mealsCollectionView.isScrollEnabled = true
        
        
         
        self.mealsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //adding subviews to the view controller
        self.addSubview(mealsCollectionView)
        
        NSLayoutConstraint.activate([
            
            self.mealsCollectionView!.topAnchor.constraint(equalTo: self.topAnchor),
            self.mealsCollectionView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.mealsCollectionView!.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.mealsCollectionView!.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            ])
        
    }
    
    func firebaseMealFetch() {
        //Adds to the list
        //MARK: See the Products.swift for the full info
        //FIXME: need to add some fields. think through
        /*
        let newMeal = "chicken parm"
        userfirebaseMeals.document(newMeal).setData([
            
            "mealImage": "pancake",
            "mealName": newMeal,
            "mealRating": 2,
            "mealIngrediants": ["Flour","Eggs","Milk","Almond Extract","Salt","Syrup","a good"],
            "mealDescription": "test",
            "likedMeal": false,
        ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        
        */
        //finds one meal! see Products.swift for other ones
        userfirebaseMeals.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            arrayofMeals = documents.compactMap { queryDocumentSnapshot -> mealClass? in
                return try? queryDocumentSnapshot.data(as: mealClass.self)
            }
            self.mealsCollectionView.reloadData()
        }
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayofMeals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mealsCell = collectionView.dequeueReusableCell(withReuseIdentifier: mealsCCellID, for: indexPath) as! mealsCellLayout
        let mealIndex = arrayofMeals[indexPath.item]
        mealsCell.clipsToBounds = true
        mealsCell.layer.masksToBounds = true
        //print(mealIndex.mealName)
        
        //MARK: populate the preview
        //This needs to have a outline to it
        
        if mealIndex.likedMeal == true {
            //FIXEME: if you scroll fast the last on the faveorited
            //precondition?
            mealsCell.favoriteButton.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        }
        mealsCell.mealName.text = mealIndex.mealName.capitalized
        mealsCell.ratingsCount.text = "(\(mealIndex.mealRating))"
        mealsCell.mealImageView.image = UIImage(named: "\(mealIndex.mealImage)")
        
        return mealsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mealCellTap = collectionView.cellForItem(at: indexPath) as? mealsCellLayout
        //FIXME: This needs to be able to retain the indexpath from the meals array -- see meals extension collectionView.
        
        //MARK: not recognizing tap
        cellDelegate?.collectionView(collectioncell: mealCellTap, didTappedInTableview: self, IndexPath: indexPath)
        print("testing tap")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = 215
        let itemHeight = 210
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    //Space between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension mealsTableViewCell {
    func product(forIndexPath: IndexPath) -> mealClass {
        var product: mealClass!
        product = arrayofMeals[forIndexPath.item]
        return product
    }
}
