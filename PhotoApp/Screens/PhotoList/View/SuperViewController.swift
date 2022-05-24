//
//  SuperViewController.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//

import UIKit
import RxSwift

class SuperViewController: UIViewController {
    
    weak var coordinator : MainCoordinator?

    let disposeBag  = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
