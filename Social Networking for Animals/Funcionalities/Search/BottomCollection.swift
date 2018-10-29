//
//  bottonCollection.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 22/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class BottomCollection: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    let minimumInteritemSpacing: CGFloat = 5
    let minimumLineSpacing:CGFloat = 5
    var posts: [Post] = []
    
    init(posts: [Post]) {
        self.posts = posts
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBottom", for: indexPath) as! BottonCollectionViewCell
        let post = posts[indexPath.row]
        if let imagePost = post.photo{
            cell.image.image = StoreManager.loadImageFromPath(imagePost)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIScreen.main.bounds.width - (minimumInteritemSpacing + minimumLineSpacing)
        return CGSize.init(width: itemWidth/2, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}


