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
    var user: User? {
        return LoginManager.getUserLogged()
    }
    var fetchingMore = false
    var posts: [Post] = []
//    var posts: [Post] {
//        guard let entity = DataManager.getEntity(entity: "Post") else {return [] }
//        let result = DataManager.getAll(entity: entity)
//        if result.success {
//            guard let posts = result.objects as? [Post] else {return [] }
//            return posts
//        }else{
//            return []
//        }
//    }
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing:CGFloat = 10
    var tapGestureLike: UITapGestureRecognizer? = nil
    var tapGestureShare: UITapGestureRecognizer? = nil
    var tapGestureSave: UITapGestureRecognizer? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let entity = DataManager.getEntity(entity: "Post") else {return}
        let result = DataManager.getAll(entity: entity)
        if result.success {
            guard let posts = result.objects as? [Post] else {return}
            self.posts = posts
        }
//        tapGestureLike = UITapGestureRecognizer(target: self, action: #selector(likeTapped(tapGestureRecognizer:)))
//        tapGestureShare = UITapGestureRecognizer(target: self, action: #selector(sharedTapped(tapGestureRecognizer:)))
//        tapGestureSave = UITapGestureRecognizer(target: self, action: #selector(saveTapped(tapGestureRecognizer:)))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellFeed")
        collectionView.register(UINib(nibName: "LoadingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellLoading")
        //collectionView.allowsSelection = false

        // Do any additional setup after loading the view.
    }
    
    @objc func saveAction(sender: UIButton){
    }
    @objc func shareAction(sender: UIButton){
    }
    @objc func commentAction(sender: UIButton){
    }
    
    @objc func likeAction(sender: UIButton){
        guard  let cell = collectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as? FeedCollectionViewCell else {return}
        let post = posts[sender.tag]
        if isLikerOf(post: post) {
            guard let image = UIImage(named: "heart") else {return}
            cell.buttonLike.setImage(image, for: .normal)
            guard let user = self.user else {return}
            post.removeFromLikers(user)
            DataManager.saveContext()
            guard let likeCount = post.likers?.count else {return}
            cell.likeCount.text = "\(likeCount)"
        }else{
            guard let image = UIImage(named: "heart-red") else {return}
            cell.buttonLike.setImage(image, for: .normal)
            guard let user = self.user else {return}
            post.addToLikers(user)
            DataManager.saveContext()
            guard let likeCount = post.likers?.count else {return}
            cell.likeCount.text = "\(likeCount)"
        }
        
        
       
        
    }
    func isLikerOf(post: Post) -> Bool{
        guard let likers = post.likers?.allObjects as? [User] else {return false}
        let isLiked = likers.contains(where: { (user) -> Bool in
            if user.username == self.user?.username{
                return true
            }else{
                return false
            }
        })
        return isLiked
    }
    
//    @objc func likeTapped(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//        guard  let row = tapGestureRecognizer.accessibilityLabel else {
//            return
//        }
//        if let rowInt = Int(row) {
//            guard let cell = collectionView.cellForItem(at: IndexPath(row: rowInt, section: 0)) as? FeedCollectionViewCell else {return}
//            guard let image = UIImage(named: "heart-red") else {return}
//            cell.imageLike.image = image
//
//        }
//
//
//    }
//    @objc func sharedTapped(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//
//
//    }
//    @objc func saveTapped(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//
//
//    }
    

}


extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return posts.count
        }else if section == 1 && fetchingMore{
            return 1
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFeed", for: indexPath) as! FeedCollectionViewCell
            
            let post: Post = posts[indexPath.row]
            cell.likeCount.text = "\(post.likers?.count ?? 0)"
            cell.petName.text = post.pet?.name
            if let imagePostPath = post.photo {
                cell.postImage.image = StoreManager.loadImageFromPath(imagePostPath)
            }else{
                if let imageDefault = UIImage(named: "Cat"){
                    cell.postImage.image = imageDefault
                }
            }
            
            if let userName = post.pet?.owner?.username {
                cell.userName.text = "by " + userName
            }else{
                cell.userName.text = ""
            }
            if let imagePath = post.pet?.photo {
                print(imagePath)
                cell.imagePet.image = StoreManager.loadImageFromPath(imagePath)
            }
//            tapGestureLike?.accessibilityLabel = "\(indexPath.row)"
//            cell.likeView.addGestureRecognizer(tapGestureLike!)
//            cell.saveView.addGestureRecognizer(tapGestureSave!)
//            cell.shareView.addGestureRecognizer(tapGestureShare!)
            cell.buttonLike.addTarget(self, action: #selector(likeAction(sender:)), for: .touchUpInside)
            cell.saveButton.addTarget(self, action: #selector(saveAction(sender:)), for: .touchUpInside)
            cell.comentButton.addTarget(self, action: #selector(commentAction(sender:)), for: .touchUpInside)
            cell.shareButton.addTarget(self, action: #selector(shareAction(sender:)), for: .touchUpInside)
            cell.buttonLike.tag = indexPath.row
            if isLikerOf(post: post) {
                guard let image = UIImage(named: "heart-red") else {return cell}
                cell.buttonLike.setImage(image, for: .normal)
            }else{
                guard let image = UIImage(named: "heart") else {return cell}
                cell.buttonLike.setImage(image, for: .normal)
                
            }
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellLoading", for: indexPath) as! LoadingCollectionViewCell
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeigh = scrollView.contentSize.height
        if offSetY > contentHeigh - scrollView.frame.height{
            if !fetchingMore {
                beginfFetch()
            }
            
        }
    }
    
    
    func beginfFetch(){
        self.fetchingMore = true
        collectionView.reloadSections(IndexSet(integer: 1))
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            for _ in 0...6 {
                APIManager.getRandonAnimal { (error, image) in
                    if !(error == nil){
                        print("error in saving post")
                        return
                    }else{
                        let newPost = Post(context: DataManager.getContext())
                        guard let entity = DataManager.getEntity(entity: "Pet") else {return}
                        let result = DataManager.getAll(entity: entity)
                        if result.success {
                            guard let pets = result.objects as? [Pet] else {return}
                            newPost.pet = pets.randomElement()
                            guard let imagePost = image else {
                                guard let imageDefault = UIImage(named: "Dog") else{
                                    newPost.photo = ""
                                    return
                                }
                                newPost.photo = StoreManager.saving(image: imageDefault, withName: "\(imageDefault.hashValue)")
                                return
                            }
                            newPost.photo = StoreManager.saving(image: imagePost, withName: "\(imagePost.hashValue)")
                            print("testing")
                            DataManager.saveContext()
                        }
                        
                    }
                }
            }
            guard let entity = DataManager.getEntity(entity: "Post") else {return}
            let result = DataManager.getAll(entity: entity)
            if result.success {
                guard let posts = result.objects as? [Post] else {return}
                self.posts.removeAll()
                self.posts = posts
            }
            self.collectionView.reloadData()
            self.fetchingMore = false
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let itemWidth = UIScreen.main.bounds.width 
        if indexPath.section == 0 {
            let itemHeight = UIScreen.main.bounds.height - (minimumInteritemSpacing + minimumLineSpacing)
            return CGSize.init(width: itemWidth, height: itemHeight/1.5)
        }else{
            return CGSize.init(width: itemWidth, height: 50)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}

extension UIView {
    
    func dropShadow() {
        let containerView = UIView()
        let cornerRadius: CGFloat = 6.0
        
        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        
        addSubview(containerView)
        
       
    }
}

