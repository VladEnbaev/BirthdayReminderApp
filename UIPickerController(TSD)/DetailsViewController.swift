//
//  DetailsViewController.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 07.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tgTextField: UITextField!
    
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    let gender : Gender? = nil
    var person = Person(name: "", telegram: "", birthdayDate: Date.now, gender: .another)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.style = .editor
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        self.birthdayDatePicker.datePickerMode = .date
        self.birthdayDatePicker.locale = Locale(identifier: "en_US")
        updateSaveButtonState()
    }
    
    //checking fields
    private func updateSaveButtonState(){
        let nameText = nameTextField.text ?? ""
//        let tgText = tgTextField.text ?? ""
        
        self.saveButton.isEnabled = !nameText.isEmpty
    }
    
    //action that connect with textFields and datePicker
    @IBAction func dataChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    //hide of keyboard if user touch on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        
        let name = nameTextField.text ?? ""
        let telegram = tgTextField.text ?? ""
        let birthday : Date = birthdayDatePicker.date
        let gender = Gender.another
        
        self.person = Person(name: name, telegram: telegram, birthdayDate: birthday, gender: gender)
    }
}



extension DetailsViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Gender.allCases[row].rawValue
    }
}
