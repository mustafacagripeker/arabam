//
//  CarDetailTableViewCell.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 12.01.2022.
//

import UIKit

class CarDetailTableViewCell: UITableViewCell {

    @IBOutlet var CarDetailBackgroundView: UIView!
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(key : String , value : String){
        keyLabel.text = key
        valueLabel.text = value
    }
    
}
