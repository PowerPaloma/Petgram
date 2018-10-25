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
    
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing:CGFloat = 10
    
    var user: User?
    var pets: [Pet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.pets = getPets()
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
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPets", for: indexPath) as! PetsCollectionViewCell
        
        guard let pets = self.pets else {return cell}
        let pet = pets[indexPath.row]
        

        cell.namePet.text = pet.name
        cell.kindAnimal.text = pet.type
        cell.followersCount.text = "\(pet.followersCount)"
        cell.likesCount.text = "\(pet.likeCount)"
        cell.photosCount.text = "\(pet.photoCount) "
        
        
        guard let imagePath = pet.photo else {
            cell.imagePet.image = UIImage(named: "Cat")
            return cell
        }
        cell.imagePet.image = StoreManager.loadImageFromPath(imagePath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.size.width - (minimumInteritemSpacing + minimumLineSpacing)
        return CGSize.init(width: itemWidth/2.5, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}
