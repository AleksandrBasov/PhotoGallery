//
//  PhotoGalleryVC.swift
//  PhotoGallery
//
//  Created by Александр Басов on 12/27/21.
//

import UIKit
import SafariServices

class PhotoGalleryVC: UIViewController {

    // - UI
    @IBOutlet weak var collectionView: UICollectionView!
    
    // - ViewModel
    private let viewModel = PhotoGalleryViewModel()
    
    // - DataSource
    private var dataSource: PhotoGalleryDataSource?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    @IBAction func pinchCollectionView(_ sender: UIPinchGestureRecognizer) {
        if sender.scale < 1 {
            viewModel.const = CGSize(width: UIScreen.main.bounds.width / 2 , height: UIScreen.main.bounds.height / 2.5)
        } else {
            viewModel.const = collectionView.bounds.size
        }
        collectionView.reloadData()
    }
    
    @IBAction func longPressCollectionView(_ sender: UILongPressGestureRecognizer) {
    }
    
}

// MARK: - PhotoGalleryDelegate
extension PhotoGalleryVC: PhotoGalleryDelegate {
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func presentSafari(url: String) {
        guard let url = URL(string: url) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

// MARK: - ViewWillTransition
extension PhotoGalleryVC {
   
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
}

// MARK: - Configure
private extension PhotoGalleryVC {
    
    func configure() {
        viewModel.delegate = self
        makeRequest()
        configureDataSource()
        configurePinch()
    }
    
    func configureDataSource() {
        dataSource = PhotoGalleryDataSource(collectionView: collectionView, viewModel: viewModel)
        dataSource?.delegate = self
    }

    func makeRequest() {
        viewModel.fetchData()
    }
    
    func configurePinch() {
        let recognizerPinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchCollectionView(_:)))
        collectionView.addGestureRecognizer(recognizerPinch)
    }
}

