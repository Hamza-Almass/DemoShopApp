//
//  CoreDataManager.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import CoreData
import UIKit

class CoreDataManager {
    
    private init() {}
    
    static let shared = CoreDataManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let fetchRequest = NSFetchRequest<ShopEntity>.init(entityName: "ShopEntity")
    
    func fetchShopsFromCoreData() -> [ShopData] {
        let request = NSFetchRequest<ShopEntity>.init(entityName: "ShopEntity")
        do {
            let shops = try context.fetch(request)
            var arrayOfShops = [ShopData]()
            shops.forEach({
                let info = Info(lat: "\($0.info?.lat ?? 0.0)", lng: "\($0.info?.long ?? 0.0)", nearestPoint: $0.info?.nearestPoint ?? "")
                let shopData = ShopData.init(name: $0.name, details: $0.details, address: $0.address, logo: nil, cover: nil, logoImageData: $0.logoImage, coverImageData: $0.coverImage, info: info)
                arrayOfShops.append(shopData)
            })
            return arrayOfShops
        }catch{
            print(error)
            return []
        }
    }
    
    func deleteObjectFromCoreData(){
        do {
            // Fetch data
            let objects = try context.fetch(fetchRequest)
            // Delete objects
            _ = objects.map({context.delete($0)})
            // Save data
            try context.save()
        }catch{
            print("Error with Deleting object from core data")
        }
    }
    
    func saveToCoreData(shopModel: Shop) {
        context.perform {
            guard let shopModelData = shopModel.data else { return }
            shopModelData.forEach({
                
                let shopEntity = ShopEntity(context: self.context)
                shopEntity.address = $0.address
                shopEntity.details = $0.details
                shopEntity.name = $0.name
                
                let shopInfo = ShopInfoEntity(context: self.context)
                shopInfo.lat = Double($0.info?.lat ?? "") ?? 0.0
                shopInfo.long = Double($0.info?.lng ?? "") ?? 0.0
                shopInfo.nearestPoint = $0.info?.nearestPoint
                
                // Get the image
                if let logoURL = URL(string: $0.logo ?? ""){
                    do {
                        let imageData = try Data(contentsOf: logoURL)
                        shopEntity.logoImage = imageData
                    }catch{
                        print(error)
                    }
                }
                
                if let coverImageURL = URL(string: $0.cover ?? ""){
                    do {
                        let imageData = try Data(contentsOf: coverImageURL)
                        shopEntity.coverImage = imageData
                    }catch{
                        print(error)
                    }
                }
               
                
                shopInfo.shop = shopEntity
                shopEntity.info = shopInfo
                
                do {
                    try self.context.save()
                    print("saving in the core data")
                }catch{
                    fatalError("Error with save data to core data")
                }
                
                
            })
        }
    }
    
}
