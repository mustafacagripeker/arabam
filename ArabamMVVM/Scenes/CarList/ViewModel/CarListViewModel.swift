//
//  CarListViewModel.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import Foundation



class CarListViewModel : NSObject{
    
    var sortType : Int?
    var sortDirection : Int?
    var minDate : String?
    var maxDate : String?
    var minYear : Int?
    var maxYear : Int?
    var skip = Int()
    var take = Int()
    

    func getCars(completion : @escaping ([CarListModel]?)-> Void){
        CarService.shared.getCarList(sortType: sortType,
                                     sortDirection: sortDirection,
                                     minDate: minDate,
                                     maxDate: maxDate,
                                     minYear: minYear,
                                     maxYear: maxYear,
                                     skip: skip,
                                     take: 5) { cars, success in
            if success{
                completion(cars)
            }
        }
    }

}
