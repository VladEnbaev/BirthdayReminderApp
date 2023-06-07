//
//  Person.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 08.12.2022.
//

import Foundation

//model of person for convinience
struct Person : Codable {
    var name : String
    var telegram : String
    var birthdayDate : Date
    var gender : Gender
    var isFavorite : Bool = false
    var imageName : String?
}

enum Gender : String, CaseIterable, Codable {
    case another
    case man
    case woman
}
