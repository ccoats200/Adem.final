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
        mealName.backgroundColor = UIColor.blue
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
            mealImageView.heightAnchor.constraint(equalToConstant: 90),
            mealName.topAnchor.constraint(equalTo: mealImageView.bottomAnchor),
            mealName.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor),
            mealName.leftAnchor.constraint(equalTo: mealImageView.leftAnchor),
            mealName.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.topAnchor.constraint(equalTo: mealImageView.bottomAnchor),
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

class mealsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        
        let collectionViewlayouts = UICollectionViewFlowLayout()
        collectionViewlayouts.scrollDirection = .horizontal
        
        mealsCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: collectionViewlayouts)
    
        mealsCollectionView.dataSource = self
        mealsCollectionView.delegate = self
        mealsCollectionView.register(mealsCellLayout.self, forCellWithReuseIdentifier: mealsCCellID)
        mealsCollectionView.backgroundColor = UIColor.white
        mealsCollectionView.isUserInteractionEnabled = true
        mealsCollectionView.isScrollEnabled = true
        
        //Maybe delete https://theswiftdev.com/2018/06/26/uicollectionview-data-source-and-delegates-programmatically/
        mealsCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    
        let cellHeight: CGFloat = 175.0
        let cellWidth: CGFloat = 175.0
        collectionViewlayouts.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        //adding subviews to the view controller
        self.addSubview(mealsCollectionView)
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
        
        mealsCell.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
        
        mealsCell.gItem = listProducts[indexPath.item]
        mealsCell.layer.cornerRadius = 5
        
        
        return mealsCell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //product Button
    @objc func handleProduct() {
        
        //transition testing
        //let transitionCoordinator = TransitionCoordinator()
        
        let cController = productVCLayout()
        cController.hidesBottomBarWhenPushed = true
        //transition testing
        //cController.transitioningDelegate = TransitionCoordinator.self as? UIViewControllerTransitioningDelegate
        cController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        //self.present(cController, animated: true, completion: nil)
        
        print("Settings Tab is active")
    }
    
    //Space between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
