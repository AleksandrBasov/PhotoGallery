//
//  PhotoGalleryModel.swift
//  PhotoGallery
//
//  Created by Александр Басов on 12/27/21.
//

import Foundation

struct Dictionary: Codable {
    let photoURL: String?
    let userURL: String?
    let userName: String?
    let colors: [String]?

    enum CodingKeys: String, CodingKey {
        case photoURL = "photo_url"
        case userURL = "user_url"
        case userName = "user_name"
        case colors
    }
}

typealias Result = [String: Dictionary]

