//
//  FilterViewController.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 12.01.2022.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet var maximumYearTextField: UITextField!
    @IBOutlet var minimumYearTextField: UITextField!
    @IBOutlet var maximumDateTextField: UITextField!
    @IBOutlet var minimumDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    
    var minDateStr : String?
    var maxDateStr : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createDatePicker(sender: minimumDateTextField)
        createDatePicker(sender: maximumDateTextField)
    }
    
    @IBAction func applyFilterAction(_ sender: Any) {
    }
    
    @IBAction func removeFilterAction(_ sender: Any) {
        minDateStr = ""
        maxDateStr = ""
        minimumDateTextField.text = ""
        maximumDateTextField.text = ""
    }
    
    

   
    func createDatePicker(sender : UITextField){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        if sender == minimumDateTextField{
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolbar.setItems([doneBtn], animated: true)
        }else{
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed2))
            toolbar.setItems([doneBtn], animated: true)
        }
        
        
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "tr")
        
        sender.inputAccessoryView = toolbar
        sender.inputView = datePicker
    }
    
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.locale = Locale(identifier: "tr")
        minimumDateTextField.text =  formatter.string(from: datePicker.date)
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        minDateStr = formatter2.string(from: datePicker.date.setTime(hour: 0, min: 0, sec: 0) ?? Date())
        minimumDateTextField.endEditing(true)
    }
    
    @objc func donePressed2(){
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.locale = Locale(identifier: "tr")
        maximumDateTextField.text =  formatter.string(from: datePicker.date)
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        maxDateStr = formatter2.string(from: datePicker.date.setTime(hour: 0, min: 0, sec: 0) ?? Date())
        maximumDateTextField.endEditing(true)
    }

}


extension Date {
    public func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "UTC") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)

        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = min
        components.second = sec

        return cal.date(from: components)
    }
}
