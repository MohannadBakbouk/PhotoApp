//
//  Coordinator.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//
import UIKit

protocol Coordinator {
    
    var childCoordinators : [Coordinator] {get set}
    
    var navigationController : UINavigationController {get set}
    
    func start()
    
    func back()
}
