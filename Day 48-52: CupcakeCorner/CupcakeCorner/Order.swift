//
//  Order.swift
//  CupcakeCorner
//
//  Created by Kasharin Mikhail on 16.08.2023.
//

import Foundation

struct Order: Codable {
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = "Vanilla"
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        let pattern = "^(?=.*[a-zA-Z0-9])[a-zA-Z0-9 ]{3,20}$"
        
        return [name, streetAddress, city, zip].allSatisfy {
            NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: $0)
        }
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += (Double(Order.types.firstIndex(of: type) ?? 0) / 2)
        if extraFrosting {
            cost += Double(quantity)
        }
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
}
