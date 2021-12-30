//
//  CreateEventViewController.swift
//  RealmDB
//
//  Created by Ekrem Özkaraca on 29.12.2021.
//

import UIKit
import RealmSwift

class CreateEventViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var pickerContainer: UIView!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var eventTypeView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var companyNameTextField: UITextField!
    
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var endDateField: UITextField!
    let datePicker = UIDatePicker()
    var minimumDate = Date()
    @IBOutlet weak var eventButton: UIView!
    @IBOutlet weak var createEventButton: UIView!
    
    let realm = try! Realm()
    var newEvent = Events()
    
    let eventType = ["Video Konferans", "Ziyaret", "Telefon", "E-Posta"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        createDatePicker()
        let eventType : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.eventsClicked))
        self.eventTypeView.isUserInteractionEnabled = true
        self.eventTypeView.addGestureRecognizer(eventType)
        
        let eventButtonGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eventButtonClicked))
        self.eventButton.isUserInteractionEnabled = true
        self.eventButton.addGestureRecognizer(eventButtonGesture)
        
        backView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 50)
        eventButton.roundedCorners()
        createEventButton.roundedCorners()
    }
    
    @objc func eventButtonClicked() {
        print("event button clickeddddddd")
    }
    
    
    func createDatePicker() {
        startDateField.inputView = datePicker
        endDateField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateDoneButtonClicked))
        toolbar.setItems([doneButton], animated: true)
        
        startDateField.inputAccessoryView = toolbar
        endDateField.inputAccessoryView = toolbar
    }
    
    @objc func dateDoneButtonClicked() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        if startDateField.isFirstResponder {
            startDateField.text = formatter.string(from: datePicker.date)
            minimumDate = datePicker.date
        }
        if endDateField.isFirstResponder {
            
            endDateField.text = formatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
    }
    
    
    @objc func eventsClicked() {
        if self.pickerContainer.isHidden {
//            self.maskView.isHidden = false
            self.pickerContainer.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.pickerContainer.alpha = 1.0
//                self.maskView.alpha = 1.0
                self.pickerView.reloadAllComponents()
            }, completion: { (finished: Bool) in
            })
        }
    }
    @objc func cancelPickerContainer() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.pickerContainer.alpha = 0.0
//            self.maskView.alpha = 0.0
        }, completion: { (finished: Bool) in
            self.pickerContainer.isHidden = true
//            self.maskView.isHidden = true
        })
    }
    @IBAction func pickerDoneClicked(_ sender: Any) {
        cancelPickerContainer()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if (eventNameLabel.text == "") || (companyNameTextField.text == "") || (startDateField.text == "") || endDateField.text == "" {
            showToast(message: "Please fill all the areas", font: .systemFont(ofSize: 20.0))
        } else {
            newEvent.companyName = companyNameTextField.text
            newEvent.eventName = eventNameLabel.text
            newEvent.startTime = startDateField.text
            newEvent.endTime = endDateField.text
            realm.beginWrite()
            realm.add(newEvent)
            try! realm.commitWrite()
            showToast(message: "Event saved successfully ", font: .systemFont(ofSize: 20.0))
            
        }
    }
    
}

extension CreateEventViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventType[row]
    }
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//
//        let eventText = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: 30))
//        eventText.font = UIFont(name: "OpenSans", size: 16)
//        eventText.textAlignment = .center
//        eventText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.88)
//        eventText.text = eventType[row]
//        return eventText
//    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventNameLabel.text = eventType[row]
    }
}
