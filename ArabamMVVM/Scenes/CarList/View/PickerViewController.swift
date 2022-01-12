//
//  FilterViewController.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet var sortPickerView: UIPickerView!
    
    var sortTypeArray = [SortTypesStringValue]()
    var selectedSortType : SortTypesStringValue?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortPickerView.delegate = self
        sortPickerView.dataSource = self
        
        sortTypeArray = [.GelişmişSıralama,
                         .FiyatınaGöreArtan,
                         .FiyatınaGöreAzalan,
                         .YılaGöreYenidenEskiye,
                         .YılaGöreEskidenYeniye,
                         .TariheGöreYenidenEskiye,
                         .TariheGöreEskidenYeniye]
        
        
    }
    
    @IBAction func applySortingPreferenceAction(_ sender: Any) {
        
        switch selectedSortType {
        case.GelişmişSıralama:
            print("gelişmiş sıralama")
        case .FiyatınaGöreArtan:
            print("fiyatına göre artan")
        case .FiyatınaGöreAzalan:
            print("fiyatına göre azalan")
        case .YılaGöreYenidenEskiye:
            print("yıla göre yeniden eskiye")
        case .YılaGöreEskidenYeniye:
            print("yıla göre eskiden yeniye")
        case .TariheGöreYenidenEskiye:
            print("tarihe göre yeniden eskiye")
        case .TariheGöreEskidenYeniye:
            print("tarihe göre eskiden yeniye")
        default:
            print("gelişmiş sıralama")
        }
        
        self.dismiss(animated: false) {
            
        }
        
    }
    
    @IBAction func closePickerViewAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
}


extension PickerViewController : UIPickerViewDataSource , UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortTypeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortTypeArray[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSortType = sortTypeArray[row]
    }
    
    
}
