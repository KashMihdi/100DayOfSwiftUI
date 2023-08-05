//
//  Double + Extension.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import Foundation

extension Double {
    
    /// Преобразует Double в строковое представление
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    func asNumberStringPercent() -> String {
        return String(format: "%.1f", self * 100)
    }
    
    /// Преобразует Double в строковое представление
    /// ```
    /// Convert 1.2345 to "1"
    /// ```
    func asNumberStringDigit() -> String {
        return String(format: "%.0f", self)
    }
    
    /// Преобразует Double в строковое представление с символом процента
    /// ```
    /// Convert 1.2345 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberStringPercent() + "%"
    }
    
}
