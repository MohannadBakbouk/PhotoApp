//
//  MockPhotoListViewModel.swift
//  PhotoAppTests
//
//  Created by Mohannad on 5/29/22.
//

import Foundation
import RxSwift
@testable import PhotoApp

class MockPhotoListViewModel :  PhotoListViewModelProtocol {
    var input: PhotoListViewModelInput {self}
    
    var output: PhotoListViewModelOutput {self}
    
    var api: PhotoServiceProtocol
    
    var localPersistent: CoreDataManagerProtocol
    
    var reachedBottomTrigger: PublishSubject<Void>
    
    var rawPhotos: PublishSubject<SearchPhotoResponse>
    
    var cachingPhotosLocallyTrigger: PublishSubject<[SuperPhotoViewData]>
    
    var loadCachedPhotosWith: PublishSubject<ApiError>
    
    var isLoadingMore: BehaviorSubject<Bool>
    
    var photos: BehaviorSubject<[SuperPhotoViewData]>
    
    var isLoading: BehaviorSubject<Bool>
    
    var onError: PublishSubject<String>
    
    init(apiService : PhotoServiceProtocol = PhotoService() , persistent : CoreDataManagerProtocol ) {
        photos = BehaviorSubject(value: [])
        rawPhotos = PublishSubject()
        isLoading = BehaviorSubject(value: false)
        isLoadingMore = BehaviorSubject(value: false)
        reachedBottomTrigger = PublishSubject()
        cachingPhotosLocallyTrigger = PublishSubject()
        loadCachedPhotosWith = PublishSubject()
        onError = PublishSubject()
        api = apiService
        localPersistent = persistent
    }
    
    func loadPhotos() {
        
    }
    
    func configuringReachedBottomTrigger() {
        
    }
}


extension MockPhotoListViewModel {
    func loadFakeJson() -> [SuperPhotoViewData] { //
        let data = try? Data(contentsOf: Bundle.main.url(forResource: "PhotosResponse", withExtension: "json")!)
        
        let response = try! JSONDecoder().decode(SearchPhotoResponse.self, from: data!)
        
        return response.photos!.photo.map{PhotoViewData(info: $0)}.map{.photo($0)}
    }
}
