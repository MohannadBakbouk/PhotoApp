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
        let photos = PhotoListController()
        photos.coordinator = self
        pushViewControllerToStack(with: photos , isRoot: true)
    }
    
    func showPhotoDetails(info : PhotoViewData){
        print("PhotoDetails")
    }
    
    func back() {
        navigationController.popViewController(animated: true)
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
