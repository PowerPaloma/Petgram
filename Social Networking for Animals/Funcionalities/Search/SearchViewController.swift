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
    
    var topShelf: TopShelfCollection!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        topShelf = TopShelfCollection()
        //let bottonCollection = BottonCollectionViewCell()
        self.collectionViewTopShelf.register(UINib(nibName: "TopShelfCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellUp")
        self.collectionViewTopShelf.delegate = topShelf
        self.collectionViewTopShelf.dataSource = topShelf
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionViewTopShelf.reloadData()
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

