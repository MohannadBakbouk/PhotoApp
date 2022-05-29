//
//  PhotoDetailsController + BindingModel.swift
//  PhotoApp
//
//  Created by Mohannad on 5/28/22.
//
import RxSwift
import Kingfisher

extension PhotoDetailsController {
    func bindingPhotoDetailsToUI(){
        viewModel.output.photoInfo
        .subscribe(onNext : {[weak self]event in
            guard let url = URL(string: event.urlString) else {return}
            self?.imageView.kf.setImage(with: url)
        }).disposed(by: disposeBag)
    }
}
