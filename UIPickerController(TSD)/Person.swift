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
    var isFavorite : Bool = false
}

enum Gender : String, CaseIterable{
    case another
    case man
    case woman
}
