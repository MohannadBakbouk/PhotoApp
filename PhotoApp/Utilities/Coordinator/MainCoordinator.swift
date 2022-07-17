//
//  MainCoordinator.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//

import UIKit

class MainCoordinator : Coordinator {
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    init(navigation : UINavigationController) {
        childCoordinators = []
        navigationController = navigation
    }
    
    func start() {
        let splash = SplashController()
        splash.coordinator = self
        pushViewControllerToStack(with: splash)
    }
    
    func showPhotos(){
        let viewModel = PhotoListViewModel(persistent: CoreDataManager(modelName: "Photos"))
        let photos = PhotoListController(model: viewModel)
        photos.coordinator = self
        pushViewControllerToStack(with: photos , animated: false , isRoot: true)
    }
    
    func showPhotoDetails(info : PhotoViewData){
        let photoDetails = PhotoDetailsController(model: PhotoDetailsViewModel(details: info))
        photoDetails.coordinator = self
        photoDetails.modalTransitionStyle = .crossDissolve
        photoDetails.modalPresentationStyle = .fullScreen
        presentViewControllerToStack(with: photoDetails)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil) 
    }
    
    func pushViewControllerToStack(with value : UIViewController , animated : Bool = true , isRoot : Bool = false){
        if isRoot {
            navigationController.viewControllers = []
        }
        navigationController.pushViewController(value, animated: animated)
    }
    
    func presentViewControllerToStack(with value : UIViewController , animated : Bool = true){
        navigationController.present(value, animated: animated)
    }
    
    
}
