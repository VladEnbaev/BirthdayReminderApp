//
//  BDViewController.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 07.12.2022.
//

import UIKit

class BDViewController: UIViewController {

    @IBOutlet weak var birthdayTableView: UITableView!
    
    var peopleArray = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //table view
        self.birthdayTableView.dataSource = self
        self.birthdayTableView.delegate = self
        //navigation controller
        self.title = "Your Friends Birthdays"
    }
    
    
    // MARK: - Navigation
    //unwind segue from save button in DetailVC
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else { return }
        let detailsVC = segue.source as! DetailsViewController
        let recievedPerson = detailsVC.person
        
        //checks if the user back from the new screen or changed the old one
        //if row is selected it means that the user clicked on it
        if let selectedIndexPath = birthdayTableView.indexPathForSelectedRow{
            peopleArray[selectedIndexPath.row] = recievedPerson
            birthdayTableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: peopleArray.count, section: 0)
            self.peopleArray.append(recievedPerson)
            self.birthdayTableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    //prepare for segue to change data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editPersonSegue" else { return }
        
        let indexPath = birthdayTableView.indexPathForSelectedRow!
        let seguePerson = peopleArray[indexPath.row]
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let detailsVC = navigationVC.topViewController as? DetailsViewController else { return }
        detailsVC.person = seguePerson
        detailsVC.title = "\(seguePerson.name)"
    }
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
