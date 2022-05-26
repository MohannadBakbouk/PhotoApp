//
//  PhotoListViewModel.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//
import RxSwift
import RxCocoa

class PhotoListViewModel : PhotoListViewModelProtocol {
    var api: PhotoServiceProtocol
    
    var input: PhotoListViewModelInput {return self}
    
    var output: PhotoListViewModelOutput {return self}
    
    var reachedBottomTrigger: PublishSubject<Void>
    
    var photos: BehaviorSubject<[SuperPhotoViewData]>
    
    var isLoading: BehaviorSubject<Bool>
    
    var isLoadingMore: BehaviorSubject<Bool>
    
    var onError: PublishSubject<String>
    
    var rawPhotos: PublishSubject<SearchPhotoResponse>
    
    let disposeBag = DisposeBag()
    
    var searchParams : SearchParams
    
    let bannerAmount : Int
    
    init(apiService : PhotoServiceProtocol = PhotoService()) {
        photos = BehaviorSubject(value: [])
        rawPhotos = PublishSubject()
        isLoading = BehaviorSubject(value: false)
        isLoadingMore = BehaviorSubject(value: false)
        reachedBottomTrigger = PublishSubject()
        onError = PublishSubject()
        api = apiService
        searchParams = SearchParams(page: 1, size: 17)
        bannerAmount = 5
        configuringReachedBottomTrigger()
        subcribingToRawPhotos()
    }
    
    func loadPhotos() {
        isLoading.onNext(searchParams.page == 1)
        api.serachPhotos(params: searchParams)
        .bind(to: rawPhotos)
        .disposed(by: disposeBag)
    }
    
    func configuringReachedBottomTrigger() {
        
    }
    
    func subcribingToRawPhotos(){
        rawPhotos.subscribe{[weak self]  event in
            guard let self = self else { return }
            if let photos = event.element?.photos , var items =  try? self.photos.value(){
                let batch  = photos.photo.map{PhotoViewData (info: $0)}
                items.append(contentsOf: self.combinePhotosWithBannars(data: batch))
                self.photos.onNext(items)
            }
            else { // there is an error try to load from local db
                
            }
        }.disposed(by: disposeBag)
    }
    
    func combinePhotosWithBannars(data batch : [PhotoViewData]) -> [SuperPhotoViewData]  {
        var adsCount = batch.count / bannerAmount
        var result : [SuperPhotoViewData] = []
        var position = 0
        var leftCount = batch.count
        
        while leftCount != 0 {
            let bound = leftCount  > bannerAmount ? bannerAmount + position  :  leftCount + position
            let currentBatch = Array(batch[position...bound - 1])
            let castedBatch : [SuperPhotoViewData]  = currentBatch.map{.Photo($0)}
            result.append(contentsOf: castedBatch)
            if adsCount > 0 {
                result.append(.Banner(BannerViewData()))
                adsCount -= 1
            }
            position += bannerAmount
            leftCount -= castedBatch.count
        }
        
        return result
    }
}
