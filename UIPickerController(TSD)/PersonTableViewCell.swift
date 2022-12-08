//
//  PersonTableViewCell.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 08.12.2022.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
     
    func set(person: Person){
        self.nameLabel.text = person.name
        self.birthdayDate.text = person.birthdayDate.formatted()
    }
}
