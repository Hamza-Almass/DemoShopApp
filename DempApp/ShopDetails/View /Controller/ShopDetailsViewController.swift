//
//  ShopDetailsViewController.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import UIKit
import SDWebImage
import ViewAnimator

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
    @IBOutlet weak var nearestLabel: UILabel!
    
    private var shopDetailsViewModel: ShopDetailsViewModel!
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setRightBarButton()
        localizeText()
    }
   
    //MARK:- Animate views
    fileprivate func animateViews(){
        let animationType = AnimationType.zoom(scale: 0.2)
        UIView.animate(views: [shopCoverImageView], animations: [animationType],duration: 0.5)
        // Animate labels
        let animationTypeLabel = AnimationType.random()
        UIView.animate(views: [shopDetailsLabel,nearestLabel , shopNearsetPointLabel], animations: [animationTypeLabel] , duration: 1)
    }
    //MARK:- Localize text
    fileprivate func localizeText(){
        nearestLabel.text = "Nearest point".lozalization()
    }
    //MARK:- Set right bar button
    fileprivate func setRightBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "map").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleViewOnMap))
    }
    //MARK:- handle View Shop on map
    @objc fileprivate func handleViewOnMap(){
        guard let mapController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewController") as? MapViewController else { return }
        mapController.shopMapOption = .showSingleShop
        mapController.didReceivedShopData = didReceivedShopModel
        navigationController?.pushViewController(mapController, animated: true)
    }
    //MARK:- Bind UI
    fileprivate func bindUI(){
        shopDetailsViewModel.shopName.bind(to: shopNameLabel.rx.text).disposed(by: shopDetailsViewModel.disposeBag)
        shopDetailsViewModel.shopeDetails.bind(to: shopDetailsLabel.rx.text).disposed(by: shopDetailsViewModel.disposeBag)
        shopDetailsViewModel.shopNearestPoint.bind(to: shopNearsetPointLabel.rx.text).disposed(by: shopDetailsViewModel.disposeBag)
        if let coverURL = shopDetailsViewModel.shopCoverImageURL.value {
            shopCoverImageView.sd_setImage(with: coverURL, completed: nil)
        }else{
            shopDetailsViewModel.shopCoverImage.map({return UIImage(data: $0)}).bind(to: shopCoverImageView.rx.image).disposed(by: shopDetailsViewModel.disposeBag)
        }
        animateViews()
    }
    
}
