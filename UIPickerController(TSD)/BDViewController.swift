//
//  BDViewController.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 07.12.2022.
//

import UIKit

class BDViewController: UIViewController {

    @IBOutlet weak var birthdayTableView: UITableView!
    
    @IBOutlet weak var plusButton: UIBarButtonItem!
    
    var peopleArray = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.birthdayTableView.dataSource = self
        self.birthdayTableView.delegate = self
       
        self.title = "Your Friends Birthdays"
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        
    }
    
    /*
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let person = segue.destination as? DetailsViewController{
            person.delegate = self
            print("norm")
        }
        
    }
    */
}

extension BDViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peopleArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath)
                as! PersonTableViewCell
        let object = peopleArray[indexPath.row]
        cell.set(person: object)
        
        return cell
    }
}
