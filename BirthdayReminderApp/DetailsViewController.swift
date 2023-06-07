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
    
    @IBOutlet weak var personImageView: UIImageView!
    var imageName : String?
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    
    var person = Person(name: "", telegram: "", birthdayDate: Date.now, gender: .another)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //text fields
        self.nameTextField.font = UIFont.systemFont(ofSize: 18)
        self.tgTextField.font = UIFont.systemFont(ofSize: 18)
        //navigation controller
        self.navigationItem.style = .editor
        //picker
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        //datepicker
        self.birthdayDatePicker.datePickerMode = .date
        self.birthdayDatePicker.locale = Locale(identifier: "en_US")
        //important funcs
        self.updateUI()
        self.updateSaveButtonState()
        //image view
        self.personImageView.layer.cornerRadius = 10
        
    }
    
    //update UI for data from TableView for editing
    private func updateUI() {
        self.nameTextField.text = person.name
        self.tgTextField.text = person.telegram
        self.birthdayDatePicker.setDate(person.birthdayDate, animated: true)
        if let newImageName = person.imageName{
            self.imageName = newImageName
            self.personImageView.image = UIImage(named: newImageName)
        }
        let rowOfGender = Gender.allCases.firstIndex(of: person.gender)
        self.genderPicker.selectRow(Int(rowOfGender!), inComponent: 0, animated: true)
    }
    
    //checking fields
    private func updateSaveButtonState(){
        let nameText = nameTextField.text ?? ""
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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    //MARK: -Navigation
    //unwind segue
    @IBAction func photoSegue(unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "photoSegue" else { return }
        let photoCC = unwindSegue.source as! PhotoViewController
        let newImageName = photoCC.imageName
        self.imageName = newImageName
        self.personImageView.image = UIImage(named: newImageName!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "saveSegue"{
            let name = nameTextField.text ?? ""
            let telegram = tgTextField.text ?? ""
            let birthday : Date = birthdayDatePicker.date
            let gender : Gender = .allCases[genderPicker.selectedRow(inComponent: 0)]
            let newImageName = self.imageName
            self.person = Person(name: name, telegram: telegram, birthdayDate: birthday, gender: gender, imageName: newImageName)
            
        }
    }
}



extension DetailsViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let currentGender = Gender.allCases[row]
        if currentGender == .another { return "-" }
        return currentGender.rawValue
    }
}
