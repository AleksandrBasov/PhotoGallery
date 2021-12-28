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

// MARK: - Configure
private extension PhotoGalleryVC {
    
    func configure() {
        viewModel.delegate = self
        makeRequest()
        configureDataSource()
    }
    
    func configureDataSource() {
        dataSource = PhotoGalleryDataSource(collectionView: collectionView, viewModel: viewModel)
        dataSource?.delegate = self
    }

    func makeRequest() {
        viewModel.fetchData()
    }
    
}
