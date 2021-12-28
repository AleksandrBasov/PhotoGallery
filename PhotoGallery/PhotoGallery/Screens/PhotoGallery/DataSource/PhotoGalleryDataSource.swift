//
//  PhotoGalleryDataSource.swift
//  PhotoGallery
//
//  Created by Александр Басов on 12/27/21.
//

import UIKit
import SafariServices

class PhotoGalleryDataSource: NSObject {
    
    // - CollectionView
    private var collectionView: UICollectionView
    
    // - ViewModel
    private var viewModel: PhotoGalleryViewModel
    
    // - Delegate
    weak var delegate: PhotoGalleryDelegate?
    
    init(collectionView: UICollectionView, viewModel: PhotoGalleryViewModel) {
        self.collectionView = collectionView
        self.viewModel = viewModel
        super.init()
        configure()
    }
}

//MARK: - UICollectionViewDataSource
extension PhotoGalleryDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dictionary.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as? PhotoCell {
            cell.delegate = delegate
            cell.set(dictionary: viewModel.dictionary[viewModel.keys[indexPath.row]], key: viewModel.keys[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: - UICollectionViewDelegate
extension PhotoGalleryDataSource: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let value = viewModel.dictionary[viewModel.keys[indexPath.row]]
        guard let url = value?.photoURL else { return }
        delegate?.presentSafari(url: url)
    }

}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotoGalleryDataSource: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size 
    }
}


//MARK: - Configure
private extension PhotoGalleryDataSource {
    
    func configure() {
        registerCells()
        setupDataSource()
    }
    
    func setupDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    func registerCells() {
        collectionView.register(PhotoCell.nib(), forCellWithReuseIdentifier: PhotoCell.reuseID)
    }
    
}
