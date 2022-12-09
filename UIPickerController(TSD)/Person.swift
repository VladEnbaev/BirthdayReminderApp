//
//  Person.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 08.12.2022.
//

import Foundation

//model of person for convinience
struct Person {
    var name : String
    var telegram : String
    var birthdayDate : Date
    var gender : Gender
}

enum Gender : String, CaseIterable{
    case man
    case woman
    case another
}
