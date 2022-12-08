//
//  DetailsViewController.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 07.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    @IBOutlet weak var tgTextField: UITextField!
    
    @IBOutlet weak var genderPicker: UIPickerView!
    
    let gender : Gender? = nil
    var delegate : BDViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.style = .editor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.peopleArray.append(Person(name: nameTextField.text!,
                                            telegram: tgTextField.text!,
                                            birthdayDate: birthdayDatePicker.date,
                                            gender: .another))

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true) // Скрытие клавиатуры вызванной для любого объекта
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("delegate is nrm")
        if let table = sender as? BDViewController{
            self.delegate = table
            print("delegate is nrm")
        }
    }
}

