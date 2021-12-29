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
    
    var visibleIndexPath: IndexPath? = nil

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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.alpha = 0.3
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.5) {
            cell.contentView.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
            
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotoGalleryDataSource: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.const //collectionView.bounds.size
    }

}

// MARK: - UIScrollViewDelegate
extension PhotoGalleryDataSource: UIScrollViewDelegate {
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            self.visibleIndexPath = visibleIndexPath
        }
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
