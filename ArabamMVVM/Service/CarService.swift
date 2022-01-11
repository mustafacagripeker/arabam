//
//  CarService.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import Foundation
import Alamofire



class CarService{
    
    static var shared : CarService{
        return CarService()
    }
    fileprivate init(){}
    
    
    func getCarList(sortType : Int? , sortDirection : Int? , minDate : String? , maxDate : String? , minYear : Int? , maxYear : Int? , skip : Int , take : Int , completion : @escaping ([CarListModel]? , Bool)-> Void ){
        
        var params = [String:Any]()
        params["sort"] = sortType
        params["sortDirection"] = sortDirection
        params["take"] = take
        params["skip"] = skip
        params["minYear"] = minYear
        params["maxYear"] = maxYear
        params["minDate"] = minDate
        params["maxDate"] = maxDate
        
        AF.request("http://sandbox.arabamd.com/api/v1/listing",
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString).responseJSON { response in
            
            if response.data != nil && response.error == nil{
                guard let data = response.value as? [[String:Any]] else{
                    completion(nil,false)
                    return
                }
                do{
                    let json = try JSONSerialization.data(withJSONObject: data)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let carListModel = try decoder.decode([CarListModel].self, from: json)
                    completion(carListModel , true)
                    
                }catch{
                    completion(nil,true)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
}
