//
//  PhotoGalleryDelegate.swift
//  PhotoGallery
//
//  Created by Александр Басов on 12/27/21.
//

import Foundation

protocol PhotoGalleryDelegate: AnyObject {
    func reloadData()
    func presentSafari(url: String)
    func showError(text: String)
}
