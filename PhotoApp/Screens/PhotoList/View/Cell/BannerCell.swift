//
//  BannerCell.swift
//  PhotoApp
//
//  Created by Mohannad on 5/25/22.
//

import UIKit
import SnapKit

class BannerCell: UITableViewCell {
    
  private var messageLabel : UILabel = {
        let lab = UILabel()
        lab.text = "mesgaeLabel"
        lab.font = UIFont.boldSystemFont(ofSize: 22)
        lab.numberOfLines = 0
        lab.backgroundColor = UIColor(hexString: Colors.flatdark.rawValue)
        lab.layer.cornerRadius = 12
        lab.clipsToBounds = true
        lab.textAlignment = .center
        lab.textColor = .white
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupUI(){
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { maker in
            maker.top.leading.equalTo(contentView).offset(5)
            maker.trailing.bottom.equalTo(contentView).offset(-5)
            maker.height.equalTo(150)
        }
    }
    
    func configure(info : BannerViewData){
        messageLabel.text = "\(info.space)\n \(info.message)"
    }
}
