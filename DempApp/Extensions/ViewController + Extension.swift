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
    
}
