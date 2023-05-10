//
//  Event.swift
//  DiscreteRandomVariable
//
//  Created by Steven Wijaya on 10.05.2023.
//

import Foundation

struct Event: Identifiable {
    let id: UUID = UUID()
    let name: String
    var prob: Double
    var occurence: Int = 0
    var frequency: Double = 0.0
    
    mutating func calculateFrequency(n: Int) {
        frequency = Double(occurence) / Double(n)
    }
}
