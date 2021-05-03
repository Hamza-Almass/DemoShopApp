//
//  MapViewModel.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import Foundation


struct MapViewModel {
    
    var shopData: ShopData?
    var shopsData: [ShopData]?
    
    init(shopData: ShopData? , shopsData: [ShopData]?){
        self.shopData = shopData
        self.shopsData = shopsData
    }
    
    func getMapViewModels() -> [MapViewModel] {
        return (self.shopsData ?? []).map({MapViewModel.init(shopData: $0, shopsData: nil)})
    }
    
    var shopLongtiude: Double {
        get {
            return Double(self.shopData?.info?.lng ?? "") ?? 0.0
        }
    }
    
    var shopLatitude: Double {
        get {
            return Double(self.shopData?.info?.lat ?? "") ?? 0.0
        }
    }
    
    var shopName: String {
        get {
            return self.shopData?.name ?? ""
        }
    }
    
    var shopNearsetPoint: String {
        get {
            return self.shopData?.info?.nearestPoint ?? ""
        }
    }
    
}
