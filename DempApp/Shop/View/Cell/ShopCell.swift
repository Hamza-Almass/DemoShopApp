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
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.contentView.frame = self.contentView.frame.inset(by: .init(top: 12, left: 12, bottom: 12, right: 12))
        setupShadow()
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
    func setupShadow(){
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height:
                                                                                            8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.masksToBounds = false
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
