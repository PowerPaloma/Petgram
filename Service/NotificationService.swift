//
//  NotificationService.swift
//  Service
//
//  Created by Paloma Bispo on 29/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UserNotifications



class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            bestAttemptContent.title = "Nova publicação"
            bestAttemptContent.body = "Voce foi marcado em uma nova publicação"
            bestAttemptContent.categoryIdentifier = "newCategory"
            bestAttemptContent.sound = UNNotificationSound.default
            if let url = Bundle.main.url(forResource: "push",
                                         withExtension: "jpg") {
                
                if let attachment = try? UNNotificationAttachment(identifier:
                    UUID().uuidString, url: url, options: nil) {
                    self.bestAttemptContent?.attachments = [attachment]
                    self.contentHandler!(self.bestAttemptContent!)
                }
            }
//            APIManager.getRandonAnimal { (error, image) in
//                if !(error == nil){
//                    print("ERROR")
//                    self.contentHandler!(self.bestAttemptContent!)
//                }else{
//                    if let image = image {
//
//                        let imagePath = StoreManager.saving(image: image, withName: "\(image.hashValue)")
////
//                        guard let urlString = image.accessibilityIdentifier, let fileUrl = URL(string: urlString) else{
//                            self.contentHandler!(self.bestAttemptContent!)
//                            return
//                        }
//
//                        let tmpDirectory = NSTemporaryDirectory()
//                        let tmpFile = "file://".appending(tmpDirectory).appending(fileUrl.lastPathComponent)
//                        let tmpUrl = URL(string: tmpFile)!
//
//
//                        do{
//                            let attachment = try UNNotificationAttachment(identifier: "", url: tmpUrl, options: nil)
//                            self.bestAttemptContent?.attachments = [attachment]
//                            self.contentHandler!(self.bestAttemptContent!)
//                        }catch let ee{
//                            print(ee.localizedDescription)
//                            self.contentHandler!(self.bestAttemptContent!)
//                        }
////
//                }
//            }
//        }
    }
}
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
