//
//  TopShelfCollection.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 22/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class TopShelfCollection: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing:CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellUp", for: indexPath) as! TopShelfCollectionViewCell
        
        cell.lblCategory.text = animals[indexPath.row].name
        cell.imageBackgound.image = animals[indexPath.row].image
        
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

