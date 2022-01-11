//
//  CarListTableViewCell.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import UIKit
import SDWebImage

class CarListTableViewCell: UITableViewCell {

    @IBOutlet var carImageView: UIImageView!
    @IBOutlet var carTitleLabel: UILabel!
    @IBOutlet var carLocationLabel: UILabel!
    @IBOutlet var carPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    func bind(imageView : String , title : String , location : String , price : String){
        
        carImageView.sd_setImage(with: URL(string: imageView))
        carTitleLabel.text = title
        carLocationLabel.text = location
        carPriceLabel.text = price
        
    }
    
}
