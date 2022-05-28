//
//  IndicatorCell.swift
//  PhotoApp
//
//  Created by Mohannad on 5/26/22.
//
import UIKit
import MaterialComponents
import SnapKit

class IndicatorCell: UITableViewCell {
    
   private var indicator :  UIActivityIndicatorView = {
        let item = UIActivityIndicatorView()
        item.color = .red
        item.style = .medium
        return item
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupUI(){
        addSubview(indicator)
        indicator.snp.makeConstraints { maker in
            maker.size.equalTo(10)
            maker.centerX.centerY.equalTo(self)
        }
    }
    
    func startAnimaing(){
        indicator.startAnimating()
    }
}
