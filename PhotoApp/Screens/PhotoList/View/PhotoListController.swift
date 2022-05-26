//
//  ViewController.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//

import UIKit
import SnapKit

class PhotoListController: SuperViewController {

    var tableview : UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.showsVerticalScrollIndicator = false
        table.allowsMultipleSelection = false
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        return table
    }()
    
    var viewModel : PhotoListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PhotoListViewModel()
        setupUI()
        bindingUIToModel()
        viewModel.loadPhotos()
        let x = "855de8e6a9"
        print(URL(string: "farm66.static.flickr.com/\(65535)/\(50397567507)_\(x).jpg")!)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupUI(){
        navigationItem.title = "Photos"
        setupTableview()
    }
    
    func bindingUIToModel(){
        bindingCollectionViewDataSource()
    }
    
    func setupTableview(){
        tableview.register(PhotoCell.self, forCellReuseIdentifier: String(describing: PhotoCell.self))
        tableview.register(BannerCell.self, forCellReuseIdentifier: String(describing: BannerCell.self))
        view.addSubview(tableview)
        setupTableviewConstraints()
    }
    
    func setupTableviewConstraints(){
        tableview.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
    }
}


