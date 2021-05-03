//
//  ShopDetailsViewController.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import UIKit
import SDWebImage

class ShopDetailsViewController: UIViewController {
    
    var didReceivedShopModel: ShopData? {
        didSet {
            guard let shopData = didReceivedShopModel else { return }
            shopDetailsViewModel = ShopDetailsViewModel(shopData: shopData)
        }
    }
    
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopCoverImageView: UIImageView!
    @IBOutlet weak var shopDetailsLabel: UILabel!
    @IBOutlet weak var shopNearsetPointLabel: UILabel!
    @IBOutlet weak var viewonMapButton: UIButton!
    @IBOutlet weak var brefLabel: UILabel!
    @IBOutlet weak var nearestLabel: UILabel!
    
    private var shopDetailsViewModel: ShopDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setRightBarButton()
        addShadowToView(myView: shopCoverImageView)
        
        brefLabel.text = "Bref".lozalization()
        nearestLabel.text = "Nearest point".lozalization()
        
    }
    fileprivate func setRightBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "map").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleViewOnMap))
    }
    @objc fileprivate func handleViewOnMap(){
        guard let mapController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewController") as? MapViewController else { return }
        mapController.shopMapOption = .showSingleShop
        mapController.didReceivedShopData = didReceivedShopModel
        navigationController?.pushViewController(mapController, animated: true)
    }
    fileprivate func bindUI(){
        shopDetailsViewModel.shopName.bind(to: shopNameLabel.rx.text).disposed(by: shopDetailsViewModel.disposeBag)
        shopDetailsViewModel.shopeDetails.bind(to: shopDetailsLabel.rx.text).disposed(by: shopDetailsViewModel.disposeBag)
        shopDetailsViewModel.shopNearestPoint.bind(to: shopNearsetPointLabel.rx.text).disposed(by: shopDetailsViewModel.disposeBag)
        if let coverURL = shopDetailsViewModel.shopCoverImageURL.value {
            shopCoverImageView.sd_setImage(with: coverURL, completed: nil)
        }else{
            shopDetailsViewModel.shopCoverImage.map({return UIImage(data: $0)}).bind(to: shopCoverImageView.rx.image).disposed(by: shopDetailsViewModel.disposeBag)
        }

    }
    
}
