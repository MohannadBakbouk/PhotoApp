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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupUI(){
        navigationItem.title = "Photos"
        setupTableview()
    }
    
    func setupTableview(){
        tableview.register(PhotoCell.self, forCellReuseIdentifier: String(describing: PhotoCell.self))
        view.addSubview(tableview)
        setupTableviewConstraints()
    }
    
    func setupTableviewConstraints(){
        tableview.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
    }
}


