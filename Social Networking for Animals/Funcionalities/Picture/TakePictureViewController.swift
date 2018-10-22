//
//  TakePictureViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 18/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import AVFoundation

class TakePictureViewController: UIViewController {
    
    @IBOutlet weak var camera: UIView!
    @IBOutlet weak var captureImage: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(takePhoto(_:)))
        captureImage.isUserInteractionEnabled = true
        captureImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let videoPreview = CameraHandler.shared.videoPreviewLayer else {return}
        videoPreview.frame = camera.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CameraHandler.shared.showCameraIn(view: camera)
    }
    
    
    @objc func takePhoto(_ sender: UITapGestureRecognizer) {
        guard let imageOutput = CameraHandler.shared.stillImageOutput else {return}
        guard let videoConnection = imageOutput.connection(with: AVMediaType.video) else {return}
        imageOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
            guard let buffer = sampleBuffer else {return}
            let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
            guard let data = imageData else {return}
            let dataProvider = CGDataProvider(data: data as CFData)
            let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.relativeColorimetric)
            
            let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImage.Orientation.right)
            //self.pickedImage = image
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

