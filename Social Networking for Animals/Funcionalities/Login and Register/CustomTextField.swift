//
//  CustomTextField.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 23/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var imageView: UIImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.borderStyle = .none
        setupImageView()
    }
    
    func roundCorners(corners:UIRectCorner, radius:CGFloat) {
        let bounds = self.bounds
        
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        
        self.layer.mask = maskLayer
        
        let frameLayer = CAShapeLayer()
        frameLayer.frame = bounds
        frameLayer.path = maskPath.cgPath
        frameLayer.strokeColor = UIColor.darkGray.cgColor
        frameLayer.fillColor = UIColor.init(red: 247, green: 247, blue: 247, alpha: 0).cgColor
        
        self.layer.addSublayer(frameLayer)
    }
    
    func setupImageView() {
        imageView = UIImageView(frame: CGRect(x:5,y:0,width:35,height:25))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.leftView = imageView
        self.leftViewMode = .always
    }
    
    
    func roundTopCornersRadius(radius:CGFloat) {
        roundCorners(corners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius:radius)
    }
    
    func roundBottomCornersRadius(radius:CGFloat) {
        roundCorners(corners: [UIRectCorner.bottomLeft, UIRectCorner.bottomRight], radius:radius)
    }
    
}
