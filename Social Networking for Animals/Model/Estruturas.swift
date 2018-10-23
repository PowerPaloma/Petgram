//
//  Struct.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 22/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

struct Animal {
    var name: String?
    var image: UIImage?
}

struct Fox: Codable {
    var image: String?
    var link: String?
}
extension Fox {
    enum CodingKeys: String, CodingKey {
        case image
        case link
    }
}

struct Cat: Codable {
    var file: String?
}
extension Cat {
    enum CodingKeys: String, CodingKey {
        case file
    }
}

struct Dog: Codable {
    var url: String?
}
extension Dog {
    enum CodingKeys: String, CodingKey {
        case url
    }
}
