//
//  BDViewController.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 07.12.2022.
//

import UIKit

extension Date {
    static func fromString(_ value: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let newDate = dateFormatter.date(from: value) {
            return newDate
        } else {
            return nil
        }
    }
}
class BDViewController: UIViewController {

    @IBOutlet weak var birthdayTableView: UITableView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var peopleArray : [Person] = []
    
    var storage : StorageManagerProtocol = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load data from User Defaults
        loadDataFromUserDef()
        //table view
        self.birthdayTableView.dataSource = self
        self.birthdayTableView.delegate = self
        //navigation controller
        self.title = "Your Friends Birthdays"
        //edit button
        self.editButton.title = "Edit"
    
    }
    
    @IBAction func editButtonTaped(_ sender: UIBarButtonItem) {
        if !self.birthdayTableView.isEditing{
            self.birthdayTableView.setEditing(true, animated: true)
            self.editButton.title = "Done"
            self.editButton.style = .done
        } else {
            self.birthdayTableView.setEditing(false, animated: true)
            self.editButton.title = "Edit"
            self.editButton.style = .plain
        }
    }
    
    func loadDataFromUserDef(){
        guard let userDefaultsPeopleArray : [Person] = storage.codableData(forKey: .peopleArray) else { return }
        self.peopleArray = userDefaultsPeopleArray
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
            birthdayTableView.reloadData()
        }
        storage.set(object: peopleArray, forKey: .peopleArray)
    }
    
    //prepare for segue to change data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editPersonSegue" else { return }
        
        let indexPath = birthdayTableView.indexPathForSelectedRow!
        let seguePerson = peopleArray[indexPath.row]
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            peopleArray.remove(at: indexPath.row)
            birthdayTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedPerson = peopleArray.remove(at: sourceIndexPath.row)
        peopleArray.insert(movedPerson, at: destinationIndexPath.row)
        birthdayTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [likeAction(at: indexPath)])
    }
    func likeAction(at indexPath: IndexPath) -> UIContextualAction {
        var newPerson = peopleArray[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "") { [unowned self] (action, view, completion) in
            newPerson.isFavorite = !newPerson.isFavorite
            self.peopleArray[indexPath.row] = newPerson
            completion(true)
        }
        action.backgroundColor = .systemIndigo
        let filledHeart = UIImage(systemName: "heart.fill")
        let heart = UIImage(systemName: "heart")
        let image = newPerson.isFavorite ? filledHeart : heart
        action.image = image
        
        return action
    }
}


//Person(name: "Nika", telegram: "milaska", birthdayDate: Date.fromString("16.09.2004")!, gender: .woman),
//                   Person(name: "Vlad", telegram: "01001010", birthdayDate: Date.fromString("01.10.2004")!, gender: .man),
//                   Person(name: "Emir", telegram: "debil", birthdayDate: Date.fromString("22.09.2004")!, gender: .man)
