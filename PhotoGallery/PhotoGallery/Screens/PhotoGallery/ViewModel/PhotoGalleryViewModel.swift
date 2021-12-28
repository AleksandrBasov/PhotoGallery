//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Александр Басов on 12/27/21.
//

import Foundation

class PhotoGalleryViewModel {
    
    // - Data
    var dictionary: Result = [:]
    var keys: [String] = []
    
    // - Delegate
    weak var delegate: PhotoGalleryDelegate?
    
    // - Managers
    private let network = NetworkManager.shared
    
    func fetchData() {
        network.getDictionary { values in
            self.dictionary = values
            for (key, _) in values {
                self.keys.append(key)
            }
            self.delegate?.reloadData()
        } onError: { error in
            print(error)
        }
    }
}
