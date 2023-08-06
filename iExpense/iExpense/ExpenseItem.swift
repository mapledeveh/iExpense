//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Alex Nguyen on 2023-05-20.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
