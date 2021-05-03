//
//  ViewController + Extension.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    
    func showProgressHud() -> JGProgressHUD {
        let progressHud = JGProgressHUD(style: .dark)
        progressHud.textLabel.text = "Loading..."
        progressHud.detailTextLabel.text = "Please wait while fetching shops."
        progressHud.show(in: self.view)
        return progressHud
    }
    
    func hideProgressHud(progressHud: JGProgressHUD){
        progressHud.dismiss(afterDelay: 2)
    }
    
    func addShadowToView(myView: UIView){
        myView.layer.cornerRadius = 8
        myView.clipsToBounds = true
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOffset = .init(width: 0, height: 1)
        myView.layer.shadowRadius = 4
        myView.layer.shadowOpacity = 4
        myView.layer.masksToBounds = false
    }
}
