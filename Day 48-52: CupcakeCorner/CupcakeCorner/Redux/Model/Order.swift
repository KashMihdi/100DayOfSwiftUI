//
//  Order.swift
//  CupcakeCorner
//
//  Created by Kasharin Mikhail on 16.08.2023.
//

import Foundation

public struct Order: Codable {

    var type = "Vanilla"
    var quantity = 3

    var specialRequestEnabled = false
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
}
