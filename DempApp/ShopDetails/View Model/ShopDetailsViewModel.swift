//
//  ShopDetailsViewModel.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import Foundation
import RxCocoa
import RxSwift

struct ShopDetailsViewModel {
    
    let shopData: ShopData
    let disposeBag = DisposeBag()
    
    init(shopData: ShopData){
        self.shopData = shopData
    }
    
    var shopName: BehaviorRelay<String> {
        get {
            return .init(value: self.shopData.name ?? "")
        }
    }
    
    var shopAddress: BehaviorRelay<String> {
        get {
            return .init(value: self.shopData.address ?? "")
        }
    }
    
    var shopeDetails: BehaviorRelay<String> {
        get {
            return .init(value: self.shopData.details ?? "")
        }
    }
    
    var shopImageLogoURL: BehaviorRelay<URL?> {
        get {
            return .init(value: URL(string: self.shopData.logo ?? "") ?? nil)
        }
    }
    
    var shopCoverImageURL: BehaviorRelay<URL?> {
        get {
            return .init(value: URL(string: self.shopData.cover ?? "") ?? nil)
        }
    }
    
    var shopNearestPoint: BehaviorRelay<String> {
        get {
            return .init(value: self.shopData.info?.nearestPoint ?? "")
        }
    }
    
    var shopLongtiudePoint: BehaviorRelay<Double> {
        get {
            return .init(value: Double(self.shopData.info?.lng ?? "") ?? 0.0)
        }
    }
    
    var shopLatitudePoint: BehaviorRelay<Double> {
        get {
            return .init(value: Double(self.shopData.info?.lat ?? "") ?? 0.0)
        }
    }
    
    var shopLogoImage: BehaviorRelay<Data> {
        get {
            return .init(value: self.shopData.logoImageData ?? Data())
        }
    }
    
    var shopCoverImage: BehaviorRelay<Data> {
        get {
            return .init(value: self.shopData.coverImageData ?? Data())
        }
    }
    
    
}
