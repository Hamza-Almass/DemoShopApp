//
//  ShopViewModel.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import Foundation
import RxCocoa
import RxSwift

struct ShopListViewModel {
    
    var shopDataBehiviorRelay: BehaviorRelay<[ShopData]> = .init(value: [])
    let disposeBag = DisposeBag()
    
    init(completion: @escaping (Error?) -> Void) {
       fetchShops(completion: completion)
    }
    
    func fetchShops(completion: @escaping (Error?) -> Void) {
        let url = "https://432b7a44-b7f7-471e-b0ae-0f7003aa21a7.mock.pstmn.io/v1/shops"
        WebService.shared.fetchData(url: url, type: Shop.self) { result in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let shop):
                DispatchQueue.main.async {
                    guard let data = shop.data else { return }
                    CoreDataManager.shared.deleteObjectFromCoreData()
                    CoreDataManager.shared.saveToCoreData(shopModel: shop)
                    shopDataBehiviorRelay.accept(data)
                    completion(nil)
                }
            }
        }
    }
    
}

/*
struct ShopViewModel {
    
    private let shopData: ShopData
    
    init(data: ShopData) {
        self.shopData = data
    }
    
    var shopAddress: String {
        get {
            return self.shopData.address ?? ""
        }
    }
    
    var shopName: String {
        get {
            return self.shopData.name ?? ""
        }
    }
    
    var shopLogoURL: String {
        get {
            return self.shopData.logo ?? ""
        }
    }
    
    var shopCoverImageURL: String {
        get {
            return self.shopData.cover ?? ""
        }
    }
    
    var shopDetails: String {
        get {
            return self.shopData.details ?? ""
        }
    }
    
    var shopLontiudePoint: Double {
        get {
            return Double(self.shopData.info?.lng ?? "") ?? 0.0
        }
    }
    
    var shopLatitudePoint: Double {
        get {
            return Double(self.shopData.info?.lat ?? "") ?? 0.0
        }
    }
    
    var shopNearestPoint: String {
        get {
            return self.shopData.info?.nearestPoint ?? ""
        }
    }
    
}
*/
