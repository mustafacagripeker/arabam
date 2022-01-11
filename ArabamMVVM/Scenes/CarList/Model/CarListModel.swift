//
//  CarListModel.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import Foundation



struct CarListModel: Codable {
    var id : Int
    var title : String
    var location : Location
    var category : Category
    var modelName : String
    var price : Int
    var priceFormatted : String
    var date : String
    var dateFormatted : String
    var photo : String
    var properties : [Properties]
    
    
}



struct Location : Codable {
    var cityName : String
    var townName : String
}

struct Category : Codable{
    var id : Int
    var name : String
}

struct Properties : Codable{
    var name : String
    var value : String
}



enum SortTypes : String , CustomStringConvertible{
  case Price
  case Date
  case Year
  case None
    
  var description : String {
      return self.rawValue
  }
}


enum SortDirections : String , CustomStringConvertible{
  case Ascending
  case Descending
  case None
  
  var description : String {
      return self.rawValue
  }
}

enum PhotoSize : CustomStringConvertible{
    case defaultSize

    var description: String{
        switch self{
        case .defaultSize : return "800x600"
        }
    }
}





