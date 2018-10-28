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
struct EmailValidate: Codable {
    let email, didYouMean, user, domain: String?
    let formatValid, smtpCheck: Bool?
    let mxFound: Bool?
    let catchAll: JSONNull?
    let role, disposable, free: Bool?
    let score: Double?
}
extension EmailValidate {
    enum CodingKeys: String, CodingKey {
        case email
        case didYouMean = "did_you_mean"
        case user, domain
        case formatValid = "format_valid"
        case mxFound = "mx_found"
        case smtpCheck = "smtp_check"
        case catchAll = "catch_all"
        case role, disposable, free, score
    }
}
class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


protocol TransferData {
    func transferUser(user: User)
}


