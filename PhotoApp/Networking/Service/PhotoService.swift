//
//  PhotoService.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//
import RxSwift

protocol PhotoServiceProtocol {
    func serachPhotos(params : SearchParams) -> Observable<SearchPhotoResponse>
}

class PhotoService : PhotoServiceProtocol {
    
    var api : ApiBaseProtocol!
    
    init(api : ApiBaseProtocol = ApiBase()) {
        self.api = api
    }
    
    func serachPhotos(params: SearchParams)  -> Observable<SearchPhotoResponse> {
        return Observable.create {[weak self] observable in
            guard let self = self else {return Disposables.create()}
            self.api.request(endpoint: .getPhotos, method: .Get, params: params.toDictionary) { (response : Result<SearchPhotoResponse , ApiError>) in
                if case .success(let data) = response , data.stat == "ok"{
                    observable.onNext(data)
                }
                else if case .failure(let error) = response {
                    observable.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}


