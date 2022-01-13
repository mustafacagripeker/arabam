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
    var skip = Int()
    var take = 10
    var isLoading = false
    var finishPagination = false
    
    var filterOptions : FilterOptions?

    func getCars(completion : @escaping ([CarListModel]?)-> Void){
        CarService.shared.getCarList(sortType: sortType,
                                     sortDirection: sortDirection,
                                     minDate: filterOptions?.minDate,
                                     maxDate: filterOptions?.maxDate,
                                     minYear: filterOptions?.minYear,
                                     maxYear: filterOptions?.maxYear,
                                     skip: skip,
                                     take: take) { cars, success in
            if success{
                completion(cars)
                if cars?.isEmpty == true{
                    self.finishPagination = true
                }
            }else{
                self.finishPagination = true
            }
        }
    }

}
