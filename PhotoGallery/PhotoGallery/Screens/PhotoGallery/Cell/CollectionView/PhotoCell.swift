//
//  PhotoCell.swift
//  PhotoGallery
//
//  Created by Александр Басов on 12/27/21.
//

import UIKit
import SafariServices

class PhotoCell: UICollectionViewCell {

    // - UI
    @IBOutlet weak var authorNameButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        
    // - Managers
    private let network = NetworkManager.shared
    
    // - ViewModel
    private let viewModel = PhotoGalleryViewModel()
    
    // - Delegate
    weak var delegate: PhotoGalleryDelegate?
    
    // - Constraints
    @IBOutlet weak var heightImageView: NSLayoutConstraint!
    @IBOutlet weak var widhtImageView: NSLayoutConstraint!
    
    // - Data
    var userUrl = ""
    
    // - Register Cell
    static let reuseID = "PhotoCell"
    static func nib() -> UINib {
        return UINib(nibName: "PhotoCell",
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(dictionary: Dictionary?, key: String) {
        activityIndicator.startAnimating()

        guard let dictionary = dictionary else { return }
        self.userUrl = dictionary.userURL ?? ""
        authorNameButton.setTitle(dictionary.userName, for: .normal)
        
        guard let urlString = dictionary.photoURL else { return }
        
        network.getPhoto(key: key) { image in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.imageView.image = image
        } onError: { error in
            print(error)
            self.imageView.image = UIImage(named: "placeholder")
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        self.imageView.layer.cornerRadius = 15
    }

    
    @IBAction func nameButtonTapp(_ sender: Any) {
        self.delegate?.presentSafari(url: userUrl)
    }
}

