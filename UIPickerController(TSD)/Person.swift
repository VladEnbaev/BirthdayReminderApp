//
//  Person.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 08.12.2022.
//

import Foundation

struct Person {
    var name : String
    var telegram : String
    var birthdayDate : Date
    var gender : Gender
}

enum Gender {
    case man
    case woman
    case another
}
