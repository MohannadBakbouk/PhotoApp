//
//  PhotoListController + BindingModel.swift
//  PhotoApp
//
//  Created by Mohannad on 5/25/22.
//
import RxSwift
import RxCocoa

extension PhotoListController {
    
    func bindingTableViewDataSource(){
        viewModel.output.photos
        .bind(to: tableview.rx.items){ (table , row , model) in
            let indexPath = IndexPath(row: row, section: 0)
            switch model {
                case .photo(let info):
                       let cell = table.dequeueReusableCell(withIdentifier: String(describing: PhotoCell.self), for: indexPath) as! PhotoCell
                       cell.configure(info: info)
                       return cell
                case .banner(let info):
                    let cell = table.dequeueReusableCell(withIdentifier: String(describing: BannerCell.self), for: indexPath) as! BannerCell
                    cell.configure(info: info)
                    return cell
                case .indicator:
                    let cell = table.dequeueReusableCell(withIdentifier: String(describing: IndicatorCell.self), for: indexPath) as! IndicatorCell
                    cell.startAnimaing()
                    return cell
            }
        }.disposed(by: disposeBag)
    }
    
    func bindingTableViewScrollingEvent(){
        tableview.rx.reachedBottom
        .bind(to: viewModel.input.reachedBottomTrigger)
        .disposed(by: disposeBag)
    }
    
    func bindingSelectTableViewItem(){
           tableview.rx.modelSelected(SuperPhotoViewData.self)
           .subscribe(onNext : {[weak self] model in
               guard let self = self , case .photo(let info) = model else {return}
               self.coordinator?.showPhotoDetails(info: info)
           }).disposed(by: disposeBag)
    }
    
    func bindingTableViewLoadingIndicator(){
        tableview.setupLoadingIndicator()
        guard let indicator = tableview.backgroundView as? UIActivityIndicatorView else { return}
        viewModel.output.isLoading
        .bind(to: indicator.rx.isAnimating)
        .disposed(by: disposeBag)
    }
    
    func bindingToError(){
        viewModel.output.onError
        .observe(on: MainScheduler.asyncInstance)
        .subscribe(onNext : {[weak self] message in
            guard let self = self else {return}
            self.tableview.setMessage(message)
        }).disposed(by: disposeBag)
    }
}
