//
//  PersonTableViewCell.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 08.12.2022.
//

import UIKit

//class for custon cell
class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //func for set parametrs which we get in BDViewController
    func set(person: Person){
        //custom output date in cell
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        self.nameLabel.text = person.name
        self.birthdayDate.text =  dateFormatter.string(from: person.birthdayDate)
    }
}
