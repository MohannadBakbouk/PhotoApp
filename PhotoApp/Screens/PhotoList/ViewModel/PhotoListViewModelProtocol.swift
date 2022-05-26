//
//  PhotoListViewModelProtocol.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//

import RxSwift

typealias PhotoListViewModelEvents = PhotoListViewModelInput & PhotoListViewModelOutput & PhotoListViewModelInternal

protocol PhotoListViewModelInput {
    var reachedBottomTrigger : PublishSubject<Void> {get}
}

protocol PhotoListViewModelOutput {
    var photos : BehaviorSubject<[SuperPhotoViewData]>{get}
    
    var isLoading : BehaviorSubject<Bool> {get}
    
    var isLoadingMore : BehaviorSubject<Bool> {get}
    
    var onError : PublishSubject<String> {get}
}

protocol PhotoListViewModelInternal {
    var rawPhotos : PublishSubject<SearchPhotoResponse> {get}
}


protocol PhotoListViewModelProtocol : PhotoListViewModelEvents {
    var input : PhotoListViewModelInput {get}
    var output : PhotoListViewModelOutput {get}
    var api : PhotoServiceProtocol {get}
    func loadPhotos()
    func configuringReachedBottomTrigger()
    
}
