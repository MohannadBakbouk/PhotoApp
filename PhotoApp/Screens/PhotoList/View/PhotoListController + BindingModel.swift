//
//  PhotoListController + BindingModel.swift
//  PhotoApp
//
//  Created by Mohannad on 5/25/22.
//
import RxSwift
import RxCocoa

extension PhotoListController {
    
    func bindingCollectionViewDataSource(){
        viewModel.output.photos
        .bind(to: tableview.rx.items){ (table , row , model) in
            let indexPath = IndexPath(row: row, section: 0)
            switch model {
                case .Photo(let info):
                       let cell = table.dequeueReusableCell(withIdentifier: String(describing: PhotoCell.self), for: indexPath) as! PhotoCell
                       cell.configure(info: info)
                       return cell
                case .Banner(let info):
                    let cell = table.dequeueReusableCell(withIdentifier: String(describing: BannerCell.self), for: indexPath) as! BannerCell
                    cell.configure(info: info)
                    return cell
            }
        }.disposed(by: disposeBag)
    }
}
