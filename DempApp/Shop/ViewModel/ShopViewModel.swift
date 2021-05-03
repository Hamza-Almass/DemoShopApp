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
    var isLoadingFinish: BehaviorRelay<Bool> = .init(value: false)
    var isGetError: PublishSubject<Error?> = .init()
    let disposeBag = DisposeBag()
    
    init(completion: @escaping(Error?) -> Void) {
        fetchShops(completion: completion)
    }
    
    func fetchShops(completion: @escaping(Error?) -> Void) {
        isLoadingFinish.accept(false)
        let url = "https://432b7a44-b7f7-471e-b0ae-0f7003aa21a7.mock.pstmn.io/v1/shops"
        WebService.shared.fetchData(url: url, type: Shop.self) { result in
            isLoadingFinish.accept(true)
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let shop):
                DispatchQueue.main.async {
                    guard let data = shop.data else { return }
                    shopDataBehiviorRelay.accept(data)
                    CoreDataManager.shared.saveInCoreData(shopModel: shop)
                    completion(nil)
                }
                
            }
        }
    }
    
}

