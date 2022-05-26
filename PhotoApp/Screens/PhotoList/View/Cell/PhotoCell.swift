//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//
import UIKit
import Kingfisher
import SnapKit

class PhotoCell: UITableViewCell {
    
    var photoImageView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.kf.indicatorType = .activity
        img.backgroundColor = .lightGray
        img.layer.cornerRadius = 15
        img.layer.masksToBounds = true
        return img
    }()
    
    var titleLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.numberOfLines = 2
        lab.textAlignment = .natural
        return lab
    }()
    
    var friendLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Friend"
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.textAlignment = .natural
        return lab
    }()
    
    var friendImageView : UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy var friendStack : UIStackView =  {
       let stack = UIStackView(arrangedSubviews: [friendLabel , friendImageView])
       stack.axis = .horizontal
       stack.spacing = 10
       stack.distribution = .fill
       return stack
    }()
    
    var publicLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Public"
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.textAlignment = .natural
        return lab
    }()
    
    var publicImageView : UIImageView = {
        let img = UIImageView(image: UIImage(systemName: Icons.xmark.rawValue))
        img.tintColor = .blue
        return img
    }()
    
    lazy var publicStack : UIStackView =  {
       let stack = UIStackView(arrangedSubviews: [publicLabel , publicImageView])
       stack.axis = .horizontal
       stack.spacing = 10
       stack.distribution = .fill
       return stack
    }()
    
    var familyLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Family"
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.textAlignment = .natural
        return lab
    }()
    
    var familyImageView : UIImageView = {
        let img = UIImageView(image: UIImage(systemName: Icons.checkmark.rawValue))
        img.tintColor = .green
        return img
    }()
    
    lazy var familyStack : UIStackView =  {
       let stack = UIStackView(arrangedSubviews: [familyLabel , familyImageView])
       stack.axis = .horizontal
       stack.spacing = 10
       stack.distribution = .fill
       return stack
    }()
    
    lazy var leftContentStack : UIStackView =  {
       let stack = UIStackView(arrangedSubviews: [titleLabel , friendStack  , publicStack , familyStack])
       stack.axis = .vertical
       stack.spacing = 10
       stack.distribution = .fill
       return stack
    }()
    
    lazy var mainStack : UIStackView =  {
       let stack = UIStackView(arrangedSubviews: [photoImageView ,leftContentStack])
       stack.axis = .horizontal
       stack.spacing = 10
       stack.distribution = .fill
       stack.alignment = .center
       return stack
    }()
    
    var container : UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI(){
        selectionStyle = .none
        addSubview(container)
        container.addSubview(mainStack)
        setupUIConstraints()
    }
    
    func setupUIConstraints(){
        container.snp.makeConstraints { maker in
            maker.top.leading.equalTo(self).offset(5)
            maker.trailing.bottom.equalTo(self).offset(-5)
        }
        
        mainStack.snp.makeConstraints { maker in
            maker.top.leading.equalTo(container).offset(10)
            maker.trailing.bottom.equalTo(container).offset(-10)
        }
        
        photoImageView.snp.makeConstraints { maker in
            maker.size.equalTo(125)
        }
        
        friendImageView.snp.makeConstraints { maker in
            maker.size.equalTo(20)
        }
        
        publicImageView.snp.makeConstraints { maker in
            maker.size.equalTo(20)
        }
        
        familyImageView.snp.makeConstraints { maker in
            maker.size.equalTo(20)
        }
    }
    
    func configure(info : PhotoViewData){
        titleLabel.text = info.title
        friendImageView.setup(meta: info.freindMeta)
        publicImageView.setup(meta: info.PublicMeta)
        familyImageView.setup(meta: info.familyMeta)
        guard let url = URL(string: info.urlString) else {return}
        photoImageView.kf.setImage(with: url)
        

    }
}
