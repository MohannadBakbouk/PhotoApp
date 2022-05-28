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
    
    func setMessage(_ message : String , icon : Icons = Icons.wifiProblem){
        
        let view = UIView()
        self.backgroundView = view
        
        let msgLabel = UILabel()
        msgLabel.textAlignment = .center
        msgLabel.textColor = .lightGray
        msgLabel.numberOfLines = 2
        msgLabel.lineBreakMode = .byTruncatingMiddle
        msgLabel.text = message
        view.addSubview(msgLabel)

        let imgView  = UIImageView()
        imgView.image = UIImage(systemName : icon.rawValue)!
    
        imgView.tintColor = .lightGray
        imgView.contentMode = .scaleAspectFit
        view.addSubview(imgView)
        
        imgView.snp.makeConstraints { maker in
            maker.width.height.equalTo(50)
            maker.centerX.equalTo(view.snp.centerX)
            maker.centerY.equalTo(view.snp.centerY).offset(-75)
        }
        
        msgLabel.snp.makeConstraints { maker in
            maker.height.equalTo(60)
            maker.leading.equalTo(view.snp.leading).offset(10)
            maker.trailing.equalTo(view.snp.trailing).offset(-10)
            maker.top.equalTo(imgView.snp.bottom).offset(10)
        }
    }
    
}
