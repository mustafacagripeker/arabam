//
//  CarDetailModel.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import Foundation


struct CarDetailModel : Codable {
    var id : Int
    var title : String
    var location : Location
    var category : Category
    var modelName : String
    var price : Int
    var priceFormatted : String
    var date : String
    var dateFormatted : String
    var photos : [String]
    var properties : [Properties]
    var text : String
    var userInfo : UserInfo
}


struct UserInfo : Codable{
    var id : Int
    var nameSurname : String
    var phone : String
    var phoneFormatted : String
}


enum DetailType : String , CustomStringConvertible{
    case County
    case City
    case Category
    case Model
    case Price
    case Date
    case Km
    case Color
    case Gear
    case Year
    case fuel
    case SellerName
    case SellerPhone

    
    var description: String{
        switch self{
        case .County : return "İlçe"
        case .City : return "İl"
        case .Category : return "Kategori"
        case .Model : return "Model"
        case .Price : return "Fiyat"
        case .Date : return "İlan Tarihi"
        case .Km : return "Kilometre"
        case .Color : return "Renk"
        case .Gear : return "Vites"
        case .Year : return "Yıl"
        case .fuel : return "Yakıt"
        case .SellerName : return "Satıcı Adı"
        case .SellerPhone : return "Satıcı Tel"
        }
    }
}
