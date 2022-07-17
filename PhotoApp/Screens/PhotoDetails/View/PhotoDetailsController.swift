//
//  PhotoDetailsController.swift
//  PhotoApp
//
//  Created by Mohannad on 5/28/22.
//
import UIKit
import SnapKit
import Kingfisher

class PhotoDetailsController : SuperViewController  {
    
    var viewModel : PhotoDetailsViewModelProtocol!

    private var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.minimumZoomScale = 1.0
        scroll.maximumZoomScale = 8.0
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
     var imageView : UIImageView = {
         let img = UIImageView()
         img.contentMode =  .scaleToFill
         img.backgroundColor = .lightGray
         return img
     }()
    
    private var closeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Icons.xmarkOnly.rawValue), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        return button
    }()
    
    init(model : PhotoDetailsViewModelProtocol) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(* , unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindingPhotoDetailsToUI()
    }
    
    func setupUI(){
        view.addSubview(scrollView)
        scrollView.addSubviews(contentOf: [imageView , closeButton])
        scrollView.delegate = self
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        setupUIConstraints()
    }

    func setupUIConstraints(){
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
    
        imageView.snp.makeConstraints { maker in
            maker.edges.equalTo(scrollView.contentLayoutGuide).offset(0)
            maker.width.equalTo(scrollView.frameLayoutGuide.snp.width)
            maker.height.equalTo(scrollView.frameLayoutGuide.snp.height)
        }
        
        closeButton.snp.makeConstraints { maker in
            maker.top.equalTo(scrollView.safeAreaLayoutGuide).offset(20)
            maker.leading.equalTo(scrollView.safeAreaLayoutGuide).offset(20)
            maker.size.equalTo(50)
        }
    }
    
    @objc func closeTapped(){
        coordinator?.dismiss()
    }
}

extension PhotoDetailsController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
