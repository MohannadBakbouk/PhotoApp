//
//  PhotoListViewControllerTest.swift
//  PhotoAppTests
//
//  Created by Mohannad on 5/29/22.
//
import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import PhotoApp
class PhotoListViewControllerTests: XCTestCase {
    var viewController : PhotoListController!
    var viewModel : MockPhotoListViewModel!
    var disposeBag : DisposeBag!
    var scheduler : TestScheduler!

    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        viewModel = MockPhotoListViewModel(apiService: MockPhotoService(), persistent: MockLocalPersistent())
        viewController = PhotoListController(model: viewModel)
        disposeBag = DisposeBag()
        SceneDelegate.shared.window?.rootViewController = viewController
    }

    override func tearDownWithError() throws {
        scheduler = nil
        viewModel = nil
        disposeBag = nil
    }
    
    func testLoadingIndicatorIsShown(){
        viewController.loadViewIfNeeded()
        
        scheduler.createColdObservable([.next(0, true)])
        .bind(to: viewModel.output.isLoading)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        let indicator = viewController.tableview.backgroundView as? UIActivityIndicatorView
        
        XCTAssertNotNil(indicator , "Indicator isn't shown")
    }
    
    func testLoadingIndicatorIsAnimating(){
        viewController.loadViewIfNeeded()
        
        scheduler.createColdObservable([.next(0, true)])
        .bind(to: viewModel.output.isLoading)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        guard  let indicator = viewController.tableview.backgroundView as? UIActivityIndicatorView else {
            XCTAssert(false)
            return
        }
    
        XCTAssertTrue(indicator.isAnimating , "the loading indicator isn't animating")
   }
    

    func testErrorIsShown(){
        viewController.loadViewIfNeeded()
        
        scheduler.createColdObservable([.next(0, ApiError.internetOffline.message)])
        .bind(to: viewModel.output.onError)
        .disposed(by: disposeBag)
            
        scheduler.start()
        
        _ = XCTWaiter.wait(for: [expectation(description: "displaying error")], timeout: 5)
        
        guard let parent = viewController.tableview.backgroundView , let msglabel = parent.subviews.first as? UILabel else {
            XCTFail("Error message is not shown")
            return
        }
        XCTAssert(msglabel.text == ApiError.internetOffline.message)
    }
    
    func testPhotoListAreDisplayed(){
        viewController.loadViewIfNeeded()
        
        let photos = viewModel.loadFakeJson()
        
        scheduler.createColdObservable([.next(0, photos)])
        .bind(to: viewModel.output.photos)
        .disposed(by: disposeBag)
        scheduler.start()
        
        _ = XCTWaiter.wait(for: [expectation(description: "tableview is displaying new photos")], timeout: 5)
        XCTAssert((viewController.tableview.indexPathsForVisibleRows?.count ?? 0)  > 3)
        XCTAssert(viewController.tableview.numberOfRows(inSection: 0)  > 10)
    }
}
