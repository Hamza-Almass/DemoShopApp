//
//  ViewController.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import UIKit
import RxSwift
import RxCocoa
import ViewAnimator

class ShopListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var shopListViewModel: ShopListViewModel!
    @IBOutlet weak var shopsOnMapButton: UIButton!
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        bindTableView()
        prepareButtonStyle()
        localizeTexts()
    }
    //MARK:- Localize texts
    fileprivate func localizeTexts(){
        // Localization
        self.navigationItem.title = "ShopList".lozalization()
        shopsOnMapButton.setTitle("Shops on Map".lozalization(), for: .normal)
    }
    //MARK:- Prepare button style
    fileprivate func prepareButtonStyle(){
        shopsOnMapButton.layer.cornerRadius = 8
        shopsOnMapButton.clipsToBounds = true
        shopsOnMapButton.addTarget(self, action: #selector(handleOpenMaps), for: .touchUpInside)
    }
    //MARK:- Handle show all shops on map
    @objc fileprivate func handleOpenMaps(){
        shopsOnMapButton.bounceTapButton { [weak self] (_) in
            guard let s = self else { return }
            guard let mapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewController") as? MapViewController else { return }
            mapViewController.shopMapOption = .showAllShop
            mapViewController.didRecivedShopsData = s.shopListViewModel.shopDataBehiviorRelay.value
            s.navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
    //MARK:- Prepare table view
    fileprivate func prepareTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.contentInset = .init(top: 0, left: 8, bottom: 0, right: -8)
    }
    //MARK:- Bind table view
    fileprivate func bindTableView(){
        
        let progressHud = self.showProgressHud()
        shopListViewModel = ShopListViewModel { [weak self] error in
            guard let s = self else { return }
            s.hideProgressHud(progressHud: progressHud)
            if let error = error {
                print(error)
                s.bindCoreDataToTableView()
                return
            }
        }

        shopListViewModel.shopDataBehiviorRelay.bind(to: tableView.rx.items) { (tableView , element , model) in
             let cell = tableView.dequeueReusableCell(withIdentifier: SHOP_CELL, for: IndexPath(row: element, section: 0)) as! ShopCell
            cell.configureCell(data: model)
//            cell.accessoryType = .disclosureIndicator
//            cell.accessoryType = .
            let v = UIView()
            v.backgroundColor = .clear
            cell.selectedBackgroundView = v
            return cell
        }.disposed(by: shopListViewModel.disposeBag)
        tableViewItemSelected()
    }
    //MARK:- Item selected table view
    fileprivate func tableViewItemSelected(){
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] (indexP) in
            guard let s = self else { return }
            guard let shopDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ShopDetails") as? ShopDetailsViewController else { return }
            shopDetailsVC.didReceivedShopModel = s.shopListViewModel.shopDataBehiviorRelay.value[indexP.row]
            s.navigationController?.pushViewController(shopDetailsVC, animated: true)
            
        }).disposed(by: shopListViewModel.disposeBag)
    }
    //MARK:- Bind core data to table view
    fileprivate func bindCoreDataToTableView(){
        DispatchQueue.main.async {
            self.shopListViewModel.shopDataBehiviorRelay.accept(CoreDataManager.shared.fetchShopsFromCoreData())
        }
    }
}

