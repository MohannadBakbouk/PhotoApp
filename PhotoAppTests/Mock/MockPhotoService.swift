//
//  MockPhotoService.swift
//  PhotoAppTests
//
//  Created by Mohannad on 5/29/22.
//

import Foundation
import RxSwift

@testable import PhotoApp
class MockPhotoService : PhotoServiceProtocol {
 
    func serachPhotos(params: SearchParams) -> Observable<SearchPhotoResponse> {
        return Observable.create{ observeble in
            
            let data = try? Data(contentsOf: Bundle.main.url(forResource: "PhotosResponse", withExtension: "json")!)
            
            let response = try! JSONDecoder().decode(SearchPhotoResponse.self, from: data!)
            
            observeble.onNext(response)
            
            return Disposables.create()
        }
    }
}

