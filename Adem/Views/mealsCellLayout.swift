//
//  mealsCellLayout.swift
//  Adem
//
//  Created by Coleman Coats on 8/12/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

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
        setupViews()
    }
    
    var gItem: groceryItemCellContent? {
        didSet {
            mealImageView.image = UIImage(named: (gItem?.itemImageName)!)
            mealName.text = gItem?.itemName
            favoriteButton.isHidden = false
            
            print("set")
        }
    }
    
    /*
    
    var isEditing: Bool = false {
        didSet {
            if isEditing
            {
                //selectedButton.isHidden = !isEditing
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.selectedButton.isHidden = isEditing
                self.selectedButton.backgroundColor = UIColor.ademBlue
            } else {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                //selectedButton.isHidden = !isEditing
                selectedButton.isHidden = !isEditing
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            /*
             if isEditing && isSelected {
             selectedButton.isHidden = !isEditing
             self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
             self.selectedButton.backgroundColor = UIColor.red
             //print(selectedButton.backgroundColor)
             }*/
            
            if isSelected {
                selectedButton.isHidden = !isEditing
                //selectedButton.isHidden = !isEditing
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.selectedButton.backgroundColor = UIColor.ademBlue
                //self.tickImageView.isHidden = false
            } else {
                //self.transform = CGAffineTransform.identity
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.selectedButton.backgroundColor = nil
                //print(selectedButton.backgroundColor)
                //self.contentView.backgroundColor = UIColor.blue
                //self.tickImageView.isHidden = true
            }
        }
    }
    */
    
    @objc func selectedButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    let mealImageView: UIImageView = {
        let mealImage = UIImageView()
        //image.image = UIImage(named: itemImageName)
        mealImage.contentMode = .scaleAspectFill
        mealImage.clipsToBounds = true
        mealImage.layer.masksToBounds = true
        mealImage.layer.cornerRadius = 5
        mealImage.translatesAutoresizingMaskIntoConstraints = false
        print("rounds the corners of the image view")
        return mealImage
    }()
    
    let mealName: UILabel = {
        let mealName = UILabel()
        //name.text = "\(itemName)"
        //mealName.backgroundColor = UIColor.blue
        mealName.textAlignment = .left
        mealName.numberOfLines = 1
        mealName.adjustsFontSizeToFitWidth = true
        mealName.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return mealName
    }()

    //Delete now editing button
    let favoriteButton: UIButton = {
        let fave = UIButton()
        fave.setBackgroundImage(UIImage(named: "fave-1"), for: .normal)
        fave.setBackgroundImage(UIImage(named: "Vegan"), for: .highlighted)
        fave.clipsToBounds = true
        fave.layer.masksToBounds = true
        fave.translatesAutoresizingMaskIntoConstraints = false
        return fave
    }()
    
    func setupViews() {
        
        addSubview(mealImageView)
        print("adds the product image subview")
        addSubview(mealName)
        print("adds the product name subview")
        addSubview(favoriteButton)
        print("adds the calorie count subview")
        
        NSLayoutConstraint.activate([
            mealImageView.topAnchor.constraint(equalTo: self.topAnchor),
            mealImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mealImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mealImageView.heightAnchor.constraint(equalToConstant: 100),
            mealName.topAnchor.constraint(equalTo: mealImageView.bottomAnchor),
            mealName.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor),
            mealName.leftAnchor.constraint(equalTo: mealImageView.leftAnchor),
            mealName.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.centerYAnchor.constraint(equalTo: mealName.centerYAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: mealImageView.rightAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            
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
    
    var selectedGroceryItems = [groceryItemCellContent]()
    var selectedCells = [UICollectionViewCell]()
    
    var groceriesSelected = [String]()
    var listProducts: [groceryItemCellContent] =  []
    
    //collection view setup
    var mealsCollectionView: UICollectionView!
    let mealsCellID = "meals"
    let mealsCCellID = "Cmeals"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let mealsCollectionViewlayouts = UICollectionViewFlowLayout()
        mealsCollectionViewlayouts.scrollDirection = .horizontal
        
        
        self.mealsCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: mealsCollectionViewlayouts)
        
    
        mealsCollectionView.showsHorizontalScrollIndicator = false
        self.mealsCollectionView.dataSource = self
        self.mealsCollectionView.delegate = self
        self.mealsCollectionView.register(mealsCellLayout.self, forCellWithReuseIdentifier: mealsCCellID)
        self.mealsCollectionView.backgroundColor = UIColor.white
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
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        for i in productsGlobal! {
            print("for loop is working and there are \(listProducts.count as Any) products")
            if i.List == true {
                listProducts.append(i)
            }
        }
        
        print("there are \(listProducts.count as Any) products")
        
        
        return listProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mealsCell = collectionView.dequeueReusableCell(withReuseIdentifier: mealsCCellID, for: indexPath) as! mealsCellLayout
        //mealsCell.eachCell = self
        mealsCell.backgroundColor = UIColor.white
        
        mealsCell.gItem = listProducts[indexPath.item]
        mealsCell.layer.cornerRadius = 5
        return mealsCell
    }
    
    //product Button
    @objc func handleMeal() {
        let cController = productVCLayout()
        cController.hidesBottomBarWhenPushed = true
        cController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        //self.present(cController, animated: true, completion: nil)
        print("Collection View cell tap recognized")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = 150
        let itemHeight = 150
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleMeal()
    }
    
    
    //Space between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
