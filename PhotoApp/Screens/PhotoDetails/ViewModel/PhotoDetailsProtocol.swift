//
//  PhotoDetailsProtocol.swift
//  PhotoApp
//
//  Created by Mohannad on 5/28/22.
//
import RxSwift

typealias  PhotoDetailsViewModelEvents = PhotoDetailsViewModelInput & PhotoDetailsViewModelOutput

protocol PhotoDetailsViewModelInput {
    
}

protocol PhotoDetailsViewModelOutput{
    var photoInfo : BehaviorSubject<PhotoViewData>{get}
}

protocol PhotoDetailsViewModelProtocol : PhotoDetailsViewModelEvents {
    var input : PhotoDetailsViewModelInput {get}
    var output : PhotoDetailsViewModelOutput {get}
}
