//
//  String + Extension.swift
//  DempApp
//
//  Created by Hamza Almass on 5/4/21.
//

import Foundation


extension String {
    func lozalization() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
