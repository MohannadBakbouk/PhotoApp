//
//  SplashController.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//

import UIKit
import SnapKit
import MaterialComponents


class SplashController: UIViewController {
    weak var coordinator : MainCoordinator?
    
    var inidicatorView :  MDCActivityIndicator = {
        let item = MDCActivityIndicator()
        item.tintColor = .systemRed
        item.radius = 20
        item.cycleColors = [.systemRed]
        return item
    }()
    
    var slugLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Photo App"
        lab.textColor = .systemRed
        lab.font = UIFont.boldSystemFont(ofSize: 25)
        return lab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        routeToNextScreen()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        view.addSubviews(contentOf: [slugLabel , inidicatorView])
        setupUIConstrains()
    }
    
    func setupUIConstrains(){
        slugLabel.snp.makeConstraints { maker in
            maker.centerX.equalTo(view.snp.centerX)
            maker.centerY.equalTo(view.snp.centerY).offset(-50)

        }
        
        inidicatorView.snp.makeConstraints { maker in
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            maker.centerX.equalTo(self.view)
        }
    }
    
    func routeToNextScreen()  {
        inidicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.coordinator?.showPhotos()
        }
    }
    

}
