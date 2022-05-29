//
//  PhotoDetailsViewModel.swift
//  PhotoApp
//
//  Created by Mohannad on 5/28/22.
//
import RxSwift

class PhotoDetailsViewModel: PhotoDetailsViewModelProtocol {
    
    var input: PhotoDetailsViewModelInput {return self}
    
    var output: PhotoDetailsViewModelOutput {return self}
    
    var photoInfo: BehaviorSubject<PhotoViewData>
    
    init(details : PhotoViewData) {
        photoInfo = BehaviorSubject(value: details)
    }
}
