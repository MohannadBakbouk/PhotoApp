//
//  PhotoListViewModel.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//
import RxSwift

class PhotoListViewModel : PhotoListViewModelProtocol {
    
    var input: PhotoListViewModelInput {return self}
    
    var output: PhotoListViewModelOutput {return self}
    
    var reachedBottomTrigger: PublishSubject<Void>
    
    var photos: BehaviorSubject<[PhotoViewData]>
    
    var isLoading: BehaviorSubject<Bool>
    
    var isLoadingMore: BehaviorSubject<Bool>
    
    var onError: PublishSubject<String>
    
    var rawPhotos: PublishSubject<SearchPhotoResponse>
    
    init() {
        photos = BehaviorSubject(value: [])
        rawPhotos = PublishSubject()
        isLoading = BehaviorSubject(value: false)
        isLoadingMore = BehaviorSubject(value: false)
        reachedBottomTrigger = PublishSubject()
        onError = PublishSubject()
        configuringReachedBottomTrigger()
    }
    
    func loadPhotos() {
        
    }
    
    func configuringReachedBottomTrigger() {
        
    }
}
