//
//  AddView.swift
//  iExpense
//
//  Created by Alex Nguyen on 2023-05-21.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        expenses.items.append(ExpenseItem(name: name, type: type, amount: amount))
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
