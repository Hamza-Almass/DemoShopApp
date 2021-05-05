//
//  ShopCell.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import UIKit
import SDWebImage

class ShopCell: UITableViewCell {
    
    @IBOutlet weak var shopDetailsLabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Set layer for the image view
        logoImageView.layer.cornerRadius = 35
        self.backgroundColor = .white
        logoImageView.layer.borderWidth = 0.2
        logoImageView.layer.borderColor = UIColor.lightGray.cgColor
        setSpaceBetweenCells()
    }
    fileprivate func setSpaceBetweenCells(){
        let v = UIView()
        addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "myBackgroundColor")!
        v.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        v.heightAnchor.constraint(equalToConstant: 10).isActive = true
        v.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        v.sendSubviewToBack(self)
        v.layer.zPosition = 1
    }
    func configureCell(data: ShopData){
        if let logoURL = URL(string: data.logo ?? "") {
           logoImageView.sd_setImage(with: logoURL, completed: nil)
        }else{
            logoImageView.image = UIImage(data: data.logoImageData ?? Data())
        }
        shopNameLabel.text = data.name
        shopDetailsLabel?.text = data.details
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
