//
//  UITableView.swift
//  PhotoApp
//
//  Created by Mohannad on 5/26/22.
//
import UIKit

extension UITableView {
    func setupLoadingIndicator(){
        let indicator = UIActivityIndicatorView()
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.color = .systemRed
        indicator.hidesWhenStopped = true
        backgroundView = indicator
    }
}
