//
//  UIView.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//
import UIKit

extension UIView {
    func addSubviews(contentOf views : [UIView]) {
        for item in views {
          addSubview(item)
        }
    }
}

