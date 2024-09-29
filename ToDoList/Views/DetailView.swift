//
//  DetailView.swift
//  ToDoList
//
//  Created by GuitarLearnerJas on 18/9/2024.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    
    @State var toDo: ToDo
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    //newly added
    @State private var item = ""
    @State private var reminderIsOn: Bool = false
    @State private var dueDate: Date = .init()
    @State private var notes: String = ""
    @State private var isCompleted: Bool = false
    
    var body: some View {
        List {
            TextField("Enter To Do here", text: $item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            Toggle("Set reminder", isOn: $reminderIsOn)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            DatePicker("Date", selection: $dueDate)
                .listRowSeparator(.hidden)
                .disabled(!toDo.reminderIsOn)
            Text("Notes:")
                .padding(.top)
            TextField("Insert Notes", text: $notes, axis: .vertical)
                .listRowSeparator(.hidden)
            Toggle("Completed", isOn: $isCompleted)
                .padding(.top)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear() {
            item = toDo.item
            reminderIsOn = toDo.reminderIsOn
            dueDate = toDo.dueDate
            notes = toDo.notes
            isCompleted = toDo.isCompleted
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancell") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    toDo.item = item
                    toDo.reminderIsOn = reminderIsOn
                    toDo.dueDate = dueDate
                    toDo.notes = notes
                    toDo.isCompleted = isCompleted
                    modelContext.insert(toDo)
                    guard let _ = try? modelContext.save() else {
                        print("ERROR: Save on DetailView failed")
                        return
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(toDo: ToDo())
            .modelContainer(for: ToDo.self, inMemory: true)
    }
}
