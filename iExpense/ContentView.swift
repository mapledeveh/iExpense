//
//  ContentView.swift
//  iExpense
//
//  Created by Alex Nguyen on 2023-05-19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var deletionConfirmation = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
        
    var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                    ForEach(expenses.items, id: \.id) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                                
                                Spacer()
                                
                                Text("\(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "CAD")))")
                            }
                            .foregroundColor(item.amount <= 10 ? .green : item.amount <= 20 ? .orange : .red)
                            .accessibilityElement()
                            .accessibilityLabel("\(item.name) \(item.amount.formatted())")
                            .accessibilityHint(item.type)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section("Business") {
                    ForEach(expenses.items, id: \.id) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                                Spacer()
                                
                                Text("\(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "CAD")))")
                            }
                            .foregroundColor(item.amount <= 10 ? .green : item.amount <= 20 ? .orange : .red)
                            .accessibilityElement()
                            .accessibilityLabel("\(item.name) \(item.amount.formatted())")
                            .accessibilityHint(item.type)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
