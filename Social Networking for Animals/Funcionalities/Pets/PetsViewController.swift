//
//  PetsViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 25/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class PetsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let minimumInteritemSpacing: CGFloat = 20
    let minimumLineSpacing:CGFloat = 20
    
    var user: User? {
        return LoginManager.getUserLogged()
    }
    var pets: [Pet]{
        guard let pets = user?.pets?.allObjects as? [Pet] else {return []}
        return pets
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: "PetsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellPet")
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func getPets() -> [Pet]?{
        guard let entity = DataManager.getEntity(entity: "Pet") else {return nil}
        let result = DataManager.getAll(entity: entity)
        if result.success {
            guard let pets = result.objects as? [Pet] else {return nil}
            return pets
        }else {
            return nil
        }
    }
    

}

extension PetsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPet", for: indexPath) as! PetsCollectionViewCell
        
//        cell.contentView.layer.cornerRadius = 15.0
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = true
//        
//        cell.layer.shadowColor = UIColor.gray.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        cell.layer.shadowRadius = 10.0
//        cell.layer.shadowOpacity = 0.3
//        cell.layer.masksToBounds = false
//        cell.containerView.layer.shadowOffset = CGSize.init(width: 4.0, height: 4.0)
        
        
        //print(cell.imagePet.frame.width/2.0, "aquiiiii")
        
        //cell.imagePet.contentMode = .scaleAspectFit
        
    
        let pet = self.pets[indexPath.row]
        

        cell.namePet.text = pet.name
        cell.kindAnimal.text = pet.type
        cell.followersCount.text = "\(pet.followersCount)"
        cell.likesCount.text = "\(pet.likeCount)"
        cell.photosCount.text = "\(pet.photoCount) "
        
        
        guard let imagePath = pet.photo else {
            cell.imagePet.image = UIImage(named: "Cat")
            cell.imagePet.clipsToBounds = true
            cell.imagePet.layer.cornerRadius = cell.imagePet.frame.width/2.0
            return cell
        }
        cell.imagePet.image = StoreManager.loadImageFromPath(imagePath)
        
        cell.imagePet.clipsToBounds = true
        cell.imagePet.layer.cornerRadius = cell.imagePet.frame.width/2.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.size.width - (minimumInteritemSpacing + minimumLineSpacing)
        return CGSize.init(width: itemWidth, height: 140)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}
