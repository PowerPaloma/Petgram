//
//  SearchViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 18/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionViewTopShelf: UICollectionView!
    @IBOutlet weak var collectionViewBottom: UICollectionView!
    
    var topShelf: TopShelfCollection!
    var bottomCollection: BottomCollection!
    var posts: [Post] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let entity = DataManager.getEntity(entity: "Post") else {return}
        let result = DataManager.getAll(entity: entity)
        if result.success {
            guard let posts = result.objects as? [Post] else {return}
            self.posts = posts
        }
        topShelf = TopShelfCollection()
        bottomCollection = BottomCollection(posts: posts)
        
        self.collectionViewBottom.register(UINib(nibName: "BottonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellBottom")
        self.collectionViewTopShelf.register(UINib(nibName: "TopShelfCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellUp")
        
        self.collectionViewTopShelf.delegate = topShelf
        self.collectionViewTopShelf.dataSource = topShelf
        
        self.collectionViewBottom.delegate = bottomCollection
        self.collectionViewBottom.dataSource = bottomCollection
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionViewTopShelf.reloadData()
        self.collectionViewBottom.reloadData()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionViewTopShelf.collectionViewLayout.invalidateLay
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

