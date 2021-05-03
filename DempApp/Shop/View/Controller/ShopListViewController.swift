//
//  ViewController.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import UIKit
import RxSwift
import RxCocoa

class ShopListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var shopListViewModel: ShopListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        colorfulNavigationController()
        bindTableView()
    }
    fileprivate func prepareTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.contentInset = .init(top: 0, left: 8, bottom: 0, right: -8)
    }
    fileprivate func colorfulNavigationController(){
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "myNavigationControllerColor")!]
    }
    fileprivate func bindTableView(){
        let progressHud = self.showProgressHud()
        shopListViewModel = ShopListViewModel(completion: { [weak self] (error) in
            guard let s = self else { return }
            if let error = error {
                print(error)
                s.bindCoreDataToTableView()
                s.hideProgressHud(progressHud: progressHud)
                return
            }
            s.hideProgressHud(progressHud: progressHud)
        })
        shopListViewModel.shopDataBehiviorRelay.bind(to: tableView.rx.items) { (tableView , element , model) in
             let cell = tableView.dequeueReusableCell(withIdentifier: SHOP_CELL, for: IndexPath(row: element, section: 0)) as! ShopCell
            cell.configureCell(data: model)
            cell.accessoryType = .disclosureIndicator
            let v = UIView()
            v.backgroundColor = .clear
            cell.selectedBackgroundView = v
            return cell
        }.disposed(by: shopListViewModel.disposeBag)
    }
    fileprivate func bindCoreDataToTableView(){
        self.shopListViewModel.shopDataBehiviorRelay.accept(CoreDataManager.shared.fetchShopsFromCoreData())
    }

}

