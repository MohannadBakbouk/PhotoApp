//
//  PhotoListViewModelTest.swift
//  PhotoAppTests
//
//  Created by Mohannad on 5/29/22.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import PhotoApp
class PhotoListViewModelTests: XCTestCase {
    
    var viewModel : PhotoListViewModel!
    var disposeBag : DisposeBag!
    var scheduler : TestScheduler!

    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        viewModel = PhotoListViewModel(apiService: MockPhotoService(), persistent: MockLocalPersistent())
        disposeBag = DisposeBag()
        
    }

    override func tearDownWithError() throws {
        scheduler = nil
        viewModel = nil
        disposeBag = nil
    }

    func testIsLoadingIndicator() throws {
        let isLoading = scheduler.createObserver(Bool.self)
        
         viewModel.output.isLoading
        .bind(to: isLoading)
        .disposed(by: disposeBag)
        
         XCTAssertRecordedElements(isLoading.events, [false])
        
        viewModel.loadPhotos()
        
        XCTAssertRecordedElements(isLoading.events, [false , true])
    }
    
    func testIsFetechingFromApi() throws{
        let photos = scheduler.createObserver([SuperPhotoViewData].self)
        
        viewModel.output.photos
        .bind(to: photos)
        .disposed(by: disposeBag)
        
        viewModel.loadPhotos()
        print(photos.events.last!.value.element!.count)
        XCTAssert(photos.events.last!.value.element!.count > 10 , "Failed to fetch photos from api")
    }
    
    func testErrorWhileFetchingFromApi(){
        let error = scheduler.createObserver(String.self)
        let expectedMessage = ApiError.server.message
        
        viewModel.output.onError
        .bind(to: error)
        .disposed(by: disposeBag)
        
        viewModel.onError.onNext(ApiError.server.message)
        
        XCTAssert(error.events.last?.value.element == expectedMessage , "didnt send an error when the api fetching failed")
    }
    
    func testCachingItemsLocally(){
        viewModel.loadPhotos()
        _ = XCTWaiter.wait(for: [expectation(description: "caching feteched items")], timeout: 10)
        let cachesItems = viewModel.localPersistent.fetch(entity: Picture.self)
        XCTAssert((cachesItems?.count ?? 0)  >= 10)
    }
    
    func testLoadCachedItems(){
        let photos = scheduler.createObserver([SuperPhotoViewData].self)
         viewModel.output.photos
        .bind(to: photos)
        .disposed(by: disposeBag)
    
         scheduler.start()
        
        (viewModel.localPersistent as? MockLocalPersistent)?.loadFromFakeJson()
        _ = XCTWaiter.wait(for: [expectation(description: "loadling cached items")], timeout: 10)
         viewModel.rawPhotos.onError(ApiError.internetOffline)
         XCTAssert((photos.events.last?.value.element?.count ?? 0) > 10)
    }
}
