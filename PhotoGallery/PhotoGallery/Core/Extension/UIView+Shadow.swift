//
//  UIView+Shadow.swift
//  PhotoGallery
//
//  Created by Александр Басов on 12/28/21.
//

import UIKit

extension UIView {
    
    func addShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 8.0, height: 8.0)
        layer.shadowOpacity = 4.0
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
        layer.cornerRadius = 15.0
    }
    
    func addCornerRadius(){
        layer.masksToBounds = true
        layer.cornerRadius = 15.0
    }
}
