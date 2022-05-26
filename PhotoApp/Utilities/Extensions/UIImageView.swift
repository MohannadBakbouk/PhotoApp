//
//  x.swift
//  PhotoApp
//
//  Created by Mohannad on 5/25/22.
//
import UIKit
extension UIImageView{
    
    func setup(meta : PhotoMetaData){
        image = UIImage(systemName: meta.icon.rawValue)
        tintColor = UIColor(hexString: meta.color.rawValue)
    }
}
