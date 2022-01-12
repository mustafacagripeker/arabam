//
//  CarDetailViewModel.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import Foundation


class CarDetailViewModel : NSObject{
    
    
    var carId = Int()
    
    
    func getDetails(completion : @escaping (CarDetailModel?)->Void){
        
        CarService.shared.getCarDetails(carId: carId) { details, success in
            
            if success{
                completion(details)
            }
        }
    }
}
