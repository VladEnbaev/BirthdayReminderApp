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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.style = .editor
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        updateSaveButtonState()
    }
    
    //checking fields
    private func updateSaveButtonState(){
        let nameText = nameTextField.text ?? ""
        let tgText = tgTextField.text ?? ""
        
        self.saveButton.isEnabled = !nameText.isEmpty
    }
    
    //action that connect with textFields and datePicker
    @IBAction func dataChanged(_ sender: Any) {
        if let _ = sender as? UIDatePicker{
            saveButton.isEnabled = true
        } else {
            updateSaveButtonState()
        }
    }
    //hide of keyboard if user touch on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
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
