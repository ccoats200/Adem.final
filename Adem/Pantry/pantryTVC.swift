//
//  pantryTVC.swift
//  Adem
//
//  Created by Coleman Coats on 2/18/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Pantry cells
//List Delete protocol
protocol pantryDelegate: class {
    func delete(cell: pantryCell)
}


//MARK: Pantry Product Cell layout Final
class pantryCell: UICollectionViewCell {
    
    
    weak var delegate: pantryDelegate?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        addSubs()
        //MARK: hide at first
        addBackButton.isHidden = !isEditing
    }
    
    /*
    var gItem = productSKU() {
        didSet {
            pantryItemImageView.image = UIImage(named: (gItem.productImage)!)
            pantryItemName.text = gItem.productName
            quantity.text = "Q: \(gItem.productQuantity ?? 1)"
            expiryDate.text = "\(gItem.productExpirDate ?? "2") Days"
//            addBackButton.isHidden = !isEditing
        }
    }
    */
    
    var isEditing: Bool = false {
        didSet {
            addBackButton.isHidden = !isEditing
        }
    }
    
    
    @objc func selectedButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
        //https://www.youtube.com/watch?v=FUs9gpk04FA
    }

    
    let pantryItemImageView: UIImageView = {
        let mealImage = UIImageView()
        mealImage.contentMode = .scaleAspectFill
        mealImage.clipsToBounds = true
        mealImage.layer.masksToBounds = true
        mealImage.layer.cornerRadius = 5
        mealImage.translatesAutoresizingMaskIntoConstraints = false
        return mealImage
    }()
    
    let pantryItemName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.textAlignment = .left
        name.font = name.font.withSize(15)
        name.textColor = UIColor.ademBlue
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let quantity: UILabel = {
        let quant = UILabel()
        let n = 1
        quant.textAlignment = .left
        quant.text = "Q: \(n)"
        quant.font = quant.font.withSize(12)
        quant.textColor = UIColor.ademBlue
        quant.numberOfLines = 1
        quant.adjustsFontSizeToFitWidth = true
        quant.translatesAutoresizingMaskIntoConstraints = false
        return quant
    }()
    
    
    let expiryDate: UILabel = {
        let date = Date()
        let expire = UILabel()
        expire.textAlignment = .right
        expire.text = "5 days"
        expire.font = expire.font.withSize(15)
        expire.textColor = UIColor.ademBlue
        expire.numberOfLines = 1
        expire.adjustsFontSizeToFitWidth = true
        expire.translatesAutoresizingMaskIntoConstraints = false
        return expire
    }()
    
    //Delete now editing button
    let addBackButton: UIButton = {
        let fave = UIButton()
        fave.setBackgroundImage(UIImage(named: "addButton"), for: .normal)
        fave.clipsToBounds = true
        fave.layer.masksToBounds = true
        fave.translatesAutoresizingMaskIntoConstraints = false
        return fave
    }()
    
    
    private func addSubs() {
        
        addSubview(pantryItemImageView)
        addSubview(pantryItemName)
        addSubview(addBackButton)
        addSubview(expiryDate)
        addSubview(quantity)
        addBackButton.addTarget(self, action: #selector(selectedButtonDidTap(_:)), for: .touchUpInside)
        
        setupViews()
    }
    
    func setupViews() {
        
        NSLayoutConstraint.activate([
            pantryItemImageView.topAnchor.constraint(equalTo: self.topAnchor),
            pantryItemImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            pantryItemImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            pantryItemImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 6.5/10),
            
            addBackButton.topAnchor.constraint(equalTo: pantryItemImageView.topAnchor),
            addBackButton.rightAnchor.constraint(equalTo: pantryItemImageView.rightAnchor),
            addBackButton.widthAnchor.constraint(equalToConstant: 30),
            addBackButton.heightAnchor.constraint(equalToConstant: 30),
            
            pantryItemName.topAnchor.constraint(equalTo: pantryItemImageView.bottomAnchor),
            pantryItemName.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -5),
            pantryItemName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pantryItemName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.75/10),
            
            quantity.topAnchor.constraint(equalTo: pantryItemName.bottomAnchor),
            quantity.leftAnchor.constraint(equalTo: pantryItemName.leftAnchor),
            quantity.trailingAnchor.constraint(equalTo: expiryDate.leadingAnchor),
            quantity.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            expiryDate.heightAnchor.constraint(equalTo: quantity.heightAnchor),
            expiryDate.rightAnchor.constraint(equalTo: pantryItemName.rightAnchor),
            expiryDate.leadingAnchor.constraint(equalTo: quantity.trailingAnchor),
            expiryDate.bottomAnchor.constraint(equalTo: quantity.bottomAnchor),

            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol CustomCollectionCellDelegate: class {
    func collectionView(collectioncell: UICollectionViewCell?, didTappedInTableview TableCell: UITableViewCell)
    
}
protocol CellButtonTap: class {
    
    func buttonTapped(collectioncell: UICollectionViewCell?, button: UIButton?)
    //other delegate methods that you can define to perform action in viewcontroller
}

/*

//MARK: Pantry TableView Cell 
class pantryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedGroceryItems = [groceryItemCellContent]()
    var selectedCells = [UICollectionViewCell]()
    
    var groceriesSelected = [String]()
//    var listProducts: [groceryItemCellContent] =  []
    var listProducts = productsMaster
    var myStuff: [productSKU] = []
    
    //collection view setup
    var pantryCollectionView: UICollectionView!
    let mealsCellID = "meals"
    let mealsCCellID = "Cmeals"
    
    weak var cellDelegate: CustomCollectionCellDelegate?
    weak var buttonDelegate: CellButtonTap?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let mealsCollectionViewlayouts = UICollectionViewFlowLayout()
        mealsCollectionViewlayouts.scrollDirection = .horizontal
        
        
        
        self.pantryCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: mealsCollectionViewlayouts)
        
        
    
        pantryCollectionView.showsHorizontalScrollIndicator = false
        self.pantryCollectionView.dataSource = self
        self.pantryCollectionView.delegate = self
        self.pantryCollectionView.register(pantryCell.self, forCellWithReuseIdentifier: mealsCCellID)
        if #available(iOS 13.0, *) {
            self.pantryCollectionView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        self.pantryCollectionView.isUserInteractionEnabled = true
        self.pantryCollectionView.isScrollEnabled = true
        pantryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        
        self.pantryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //adding subviews to the view controller
        self.addSubview(pantryCollectionView)
        
        NSLayoutConstraint.activate([
            pantryCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            pantryCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pantryCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            pantryCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        for i in listProducts {
            if i.productPantry == true {
                myStuff.append(i)
            }
        }
        
        return myStuff.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pantryItemsCell = collectionView.dequeueReusableCell(withReuseIdentifier: mealsCCellID, for: indexPath) as! pantryCell
        
//        self.buttonDelegate?.buttonTapped(collectioncell: pantryItemsCell, button: pantryItemsCell.addBackButton)

        pantryItemsCell.backgroundColor = UIColor.white
//        pantryItemsCell.addBackButton.addTarget(self, action: #selector(handleMeal), for: .touchDown)
        
        for i in listProducts {
            if i.productPantry == true {
                myStuff.append(i)
                pantryItemsCell.gItem = myStuff[indexPath.item]
            }
        }
//        pantryItemsCell.gItem = listProducts[indexPath.item]
        
        pantryItemsCell.layer.cornerRadius = 5
        return pantryItemsCell
    }
    
    //product Button
    @objc func handleMeal() {
        
        print("Collection View cell tap recognized")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //MARK: Changes the size of the image in pantry
        return CGSize(width: 150, height: 150)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pantryCellTap = collectionView.cellForItem(at: indexPath) as? pantryCell
        
        
        
        self.cellDelegate?.collectionView(collectioncell: pantryCellTap, didTappedInTableview: self)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
