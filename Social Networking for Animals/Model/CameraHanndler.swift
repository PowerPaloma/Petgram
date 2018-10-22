//
//  CameraHanndler.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 18/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import AVFoundation

class CameraHandler: NSObject, AVCapturePhotoCaptureDelegate{
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var view = UIView()
    var pickedImage = UIImage()
    static let shared = CameraHandler()
    
    func showCameraIn(view: UIView) {
        var input: AVCaptureDeviceInput?
        session = AVCaptureSession()
        guard let ses = session else {return}
        ses.sessionPreset = .photo
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {return}
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error  {
            input = nil
            print(error.localizedDescription)
        }
        guard let inputAux = input else {return}
        if ses.canAddInput(inputAux) {
            ses.addInput(inputAux)
            stillImageOutput = AVCaptureStillImageOutput()
//            let settings = AVCapturePhotoSettings()
//            settings.livePhotoVideoCodecType = .jpeg
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            guard let imageOutput = stillImageOutput else {return}
            //imageOutput.capturePhoto(with: settings, delegate: self)
        
            if ses.canAddOutput(imageOutput) {
                ses.addOutput(imageOutput)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: ses)
                guard let videoPreview = videoPreviewLayer else {return}
                videoPreview.videoGravity = .resize
                videoPreview.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                view.layer.addSublayer(videoPreview)
                ses.startRunning()
            }
        }
        
    }
    
    
    
    
//    var pickedImage = UIImage()
//    var vc = UIViewController()
//
//
//    func showCameraIn(view: UIViewController) -> UIImage? {
//        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) else {return nil}
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .camera
//        vc = view
//        view.present(imagePicker, animated: true, completion: nil)
//        return pickedImage
//
//    }
}

//extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let selectedImage = info[.originalImage] as? UIImage else {return}
//        self.pickedImage = selectedImage
//
//        vc.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        vc.dismiss(animated: true, completion: nil)
//    }
//}


extension CameraHandler{
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//
////        guard let imageData = photo.fileDataRepresentation()
////            else { return }
////
////        let image = UIImage(data: imageData)
////        captureImageView.image = image
//        print("ok")
//    }
    
//    @objc func takePhoto(_ sender: UITapGestureRecognizer) {
//        guard let imageOutput = stillImageOutput else {return}
//        guard let videoConnection = imageOutput.connection(with: AVMediaType.video) else {return}
//        imageOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
//            guard let buffer = sampleBuffer else {return}
//            let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
//            guard let data = imageData else {return}
//            let dataProvider = CGDataProvider(data: data as CFData)
//            let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.relativeColorimetric)
//            
//            let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImage.Orientation.right)
//            self.pickedImage = image
//            print("dahsu")
//        })
//        
//    }
    
    
}
