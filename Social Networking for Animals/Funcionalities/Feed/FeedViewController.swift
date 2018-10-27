//
//  FeedViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 24/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var user: User?
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing:CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.delegate = self
        //collectionView.dataSource = self 

        // Do any additional setup after loading the view.
    }

}


extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFeed", for: indexPath) as! FeedCollectionViewCell
        cell.imageUser.image = UIImage(named: "Cat")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIScreen.main.bounds.width - (minimumInteritemSpacing + minimumLineSpacing)
        return CGSize.init(width: itemWidth, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}

extension UIView {
    
    func addGradient(colorTop: CGColor, colorBotton: CGColor){
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [colorTop, colorBotton]
        self.layer.addSublayer(gradient)
    }
}

