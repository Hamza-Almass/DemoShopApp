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
        let url = "https://2cd6c999-9229-49d0-a723-bd31c7b22edd.mock.pstmn.io/getShops/"
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

