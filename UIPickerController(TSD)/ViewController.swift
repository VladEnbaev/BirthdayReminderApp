//
//  ViewController.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 07.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.layer.cornerRadius = 10
        passwordTextField.isSecureTextEntry = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true) // Скрытие клавиатуры вызванной для любого объекта
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AllBD" {
            if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty{
                let alertController = UIAlertController(title: "error", message: "enter email and password", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "ok", style: .default)
                
                alertController.addAction(action)
                
                self.present(alertController, animated: true)
            }
        }
    }
}

