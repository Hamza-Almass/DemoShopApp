//
//  UIButton + Extension.swift
//  DempApp
//
//  Created by Hamza Almass on 5/4/21.
//

import UIKit

extension UIButton {
    func bounceTapButton(completion: @escaping (Bool) -> Void){
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let s = self else { return }
            s.transform = .init(scaleX: 0.75, y: 0.75)
        } completion: { [weak self] (_) in
            guard let s = self else { return }
            UIView.animate(withDuration: 0.3) {
                s.transform = .identity
                completion(true)
            }
        }
    }
}
