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
    
    var sortDelegate : SortDelegate?
    
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
            sortDelegate?.sortApplyed(type: nil, direction: nil)
        case .FiyatınaGöreArtan:
            sortDelegate?.sortApplyed(type: 0, direction: 0)
        case .FiyatınaGöreAzalan:
            sortDelegate?.sortApplyed(type: 0, direction: 1)
        case .YılaGöreYenidenEskiye:
            sortDelegate?.sortApplyed(type: 2, direction: 0)
        case .YılaGöreEskidenYeniye:
            sortDelegate?.sortApplyed(type: 2, direction: 1)
        case .TariheGöreYenidenEskiye:
            sortDelegate?.sortApplyed(type: 1, direction: 0)
        case .TariheGöreEskidenYeniye:
            sortDelegate?.sortApplyed(type: 1, direction: 1)
        default:
            sortDelegate?.sortApplyed(type: nil, direction: nil)
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
