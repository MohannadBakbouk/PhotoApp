//
//  PhotoListViewModel.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//
import RxSwift
import RxCocoa

class PhotoListViewModel : PhotoListViewModelProtocol {
    
    var localPersistent : CoreDataManagerProtocol
    
    var api: PhotoServiceProtocol
    
    var input: PhotoListViewModelInput {return self}
    
    var output: PhotoListViewModelOutput {return self}
    
    var reachedBottomTrigger: PublishSubject<Void>
    
    var photos: BehaviorSubject<[SuperPhotoViewData]>
    
    var isLoading: BehaviorSubject<Bool>
    
    var isLoadingMore: BehaviorSubject<Bool>
    
    var onError: PublishSubject<String>
    
    var rawPhotos: PublishSubject<SearchPhotoResponse>
    
    var cachingPhotosLocallyTrigger: PublishSubject<[SuperPhotoViewData]>
    
    var loadCachedPhotosWith: PublishSubject<ApiError>
    
    let disposeBag = DisposeBag()
    
    var searchParams : SearchParams
    
    let bannerAmount : Int
    
    var totalPages : Int
    
    var initializedPersistent : Bool
    
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
        searchParams = SearchParams(page: 1, size: 20)
        bannerAmount = 5
        totalPages = -1
        initializedPersistent = false
        setupLocalPeesistent()
        subscribingToEvents()
    }
    
    func loadPhotos() {
        isLoading.onNext(searchParams.page == 1)
        api.serachPhotos(params: searchParams)
        .bind(to: rawPhotos)
        .disposed(by: disposeBag)
    }
    
    func setupLocalPeesistent(){
        localPersistent.setup {[weak self] in
            self?.initializedPersistent = true
        }
    }
    
    func subscribingToEvents(){
        configuringReachedBottomTrigger()
        subcribingToRawPhotos()
        subscribingToisLoadingMore()
        subscrbingToCashinglocally()
        subscriptingToLoadCachedPhotosWith()
    }
}

extension PhotoListViewModel {
    
    func subcribingToRawPhotos(){
        rawPhotos.subscribe{[weak self]  event in
            guard let self = self else { return }
            
            self.loadCachedPhotosWith.onNext(.server)
            return
            
            if let photos = event.element?.photos , var items =  try? self.photos.value(){
                let batch  = photos.photo.map{PhotoViewData (info: $0)}
                self.totalPages = photos.pages
                _ = self.searchParams.page > 1 ?  items.removeLast() : nil // remove indicator model from the table
                items.append(contentsOf: self.combinePhotosWithBannars(data: batch))
                self.photos.onNext(items)
                self.isLoadingMore.onNext(false)
                self.cachingPhotosLocallyTrigger.onNext(items)
            }
            else { // there is an error try to load from local db
                let currentError = event.error as? ApiError ?? ApiError.errorOccured
                self.loadCachedPhotosWith.onNext(currentError)
            }
        }.disposed(by: disposeBag)
    }
    
    func configuringReachedBottomTrigger() {
        reachedBottomTrigger.filter{[weak self] in
            guard let self = self else { return false}
            return self.searchParams.page < self.totalPages
        }
        .withLatestFrom(isLoadingMore)
        .filter{$0 == false}
        .subscribe(onNext: {[weak self]  event in
            guard let self = self else { return}
            self.searchParams.page += 1
            self.isLoadingMore.onNext(true)
            self.loadPhotos()
        }).disposed(by: disposeBag)
    }
    
    func subscribingToisLoadingMore()  {
        isLoadingMore.subscribe(onNext :{ [weak self]  newValue in
            guard let self = self else { return}
            if newValue ,   var items = try? self.photos.value() {
                items.append(.indicator)
                self.photos.onNext(items)
            }
        }).disposed(by: disposeBag)
    }
    
    func subscrbingToCashinglocally(){
        cachingPhotosLocallyTrigger.subscribe (onNext :{[weak self] event in
            guard let self = self else {return}
            let items : [PhotoViewData] = event.compactMap{ item in
                guard case let .photo(info) = item else {return nil}
                return info
            }
            self.localPersistent.add(type: Picture.self, entities: items)
        }).disposed(by: disposeBag)
    }
    
    func  subscriptingToLoadCachedPhotosWith() {
         loadCachedPhotosWith.subscribe(onNext:{[weak self] error in
            guard let self = self else {return}
            guard self.initializedPersistent ,  let cached = self.localPersistent.fetch(entity: Picture.self) , cached.count > 0 else {
                self.onError.onNext(error.message)
                return
            }
            let viewItems =  cached.map{PhotoViewData(stored: $0)}
            let superViewItems = self.combinePhotosWithBannars(data: viewItems)
            self.photos.onNext(superViewItems)
            self.totalPages = 1
        }).disposed(by: disposeBag)
    }
    
    func combinePhotosWithBannars(data batch : [PhotoViewData]) -> [SuperPhotoViewData]  {
        var adsCount = batch.count / bannerAmount
        var result : [SuperPhotoViewData] = []
        var position = 0
        var leftCount = batch.count
        
        while leftCount != 0 {
            let bound = leftCount  > bannerAmount ? bannerAmount + position  :  leftCount + position
            let currentBatch = Array(batch[position...bound - 1])
            let castedBatch : [SuperPhotoViewData]  = currentBatch.map{.photo($0)}
            result.append(contentsOf: castedBatch)
            if adsCount > 0 {
                result.append(.banner(BannerViewData()))
                adsCount -= 1
            }
            position += bannerAmount
            leftCount -= castedBatch.count
        }
        return result
    }
}
