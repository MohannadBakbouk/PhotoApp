//
//  ViewController.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//
import UIKit
import SnapKit
import CoreData

class PhotoListController: SuperViewController {

    var viewModel : PhotoListViewModelProtocol!
    
    var tableview : UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.showsVerticalScrollIndicator = false
        table.allowsMultipleSelection = false
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        return table
    }()
    
    init(model : PhotoListViewModelProtocol) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(* , unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindingUIToModel()
        viewModel.loadPhotos()
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
        bindingTableViewDataSource()
        bindingSelectTableViewItem()
        bindingTableViewLoadingIndicator()
        bindingTableViewScrollingEvent()
        bindingToError()
    }
    
    func setupTableview(){
        tableview.register(PhotoCell.self, forCellReuseIdentifier: String(describing: PhotoCell.self))
        tableview.register(BannerCell.self, forCellReuseIdentifier: String(describing: BannerCell.self))
        tableview.register(IndicatorCell.self, forCellReuseIdentifier: String(describing: IndicatorCell.self))
        view.addSubview(tableview)
        setupTableviewConstraints()
    }
    
    func setupTableviewConstraints(){
        tableview.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
    }
}


