//
//  CarDetailDescriptionTableViewCell.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 14.01.2022.
//

import UIKit
import WebKit

class CarDetailDescriptionTableViewCell: UITableViewCell {
    @IBOutlet var descWebView: WKWebView!
    
    var htmlString = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func bind(htmlString : String){
        var html = """
<html>
 <head>
<style>
 * {color:black; font-size : 50px;}
</style>
 </head>
 <body>
\(htmlString)
 </body>
</html>

"""
        
        descWebView.loadHTMLString(html, baseURL: nil)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
