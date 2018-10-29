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
        if( traitCollection.forceTouchCapability == .available){
            registerForPreviewing(with: self, sourceView: collectionViewBottom)
        }
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewTopShelf.collectionViewLayout.invalidateLayout()
    }
    


}

extension SearchViewController: UIViewControllerPreviewingDelegate{
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionViewBottom.indexPathForItem(at: location) else { return nil }
        guard let cell = collectionViewBottom.cellForItem(at: indexPath) else { return nil}
        let post = posts[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let previewController = storyboard.instantiateViewController(withIdentifier: "preview") as? DetailsViewController else {return nil}
        previewController.post = post
        previewController.preferredContentSize = CGSize(width: 0.0, height: 400)
        previewingContext.sourceRect = cell.frame
        return previewController
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
        
    }
    
    
}

