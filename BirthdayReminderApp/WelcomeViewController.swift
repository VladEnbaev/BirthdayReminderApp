//
//  ViewController.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 07.12.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.layer.cornerRadius = 10
        passwordTextField.isSecureTextEntry = true
    }
    
    //hide of keyboard if user touch on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    @IBAction func enterButtonTapped(_ sender: Any) {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty{
            showAlert()
        } else {
            moveToNextVC(isFirstEnter: false)
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "error", message: "enter email and password", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default)
        alertController.addAction(action)
        
        self.present(alertController, animated: true)
    }
    
    private func moveToNextVC(isFirstEnter: Bool) {
        StorageManager.shared.set(false, forKey: .isFirstEnter)
        let storyboard = UIStoryboard(name: R.StoryboardIDs.storyboardName, bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: R.StoryboardIDs.homeViewControllerID)
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

