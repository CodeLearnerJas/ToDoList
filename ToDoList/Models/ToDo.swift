//
//  ToDo.swift
//  ToDoList
//
//  Created by GuitarLearnerJas on 20/9/2024.
//

import Foundation
import SwiftData

@MainActor
@Model
class ToDo {
    var item: String = ""
    var reminderIsOn = false
    var dueDate = Date.now + 3600*24
    var notes = ""
    var isCompleted = false
    
    //Have to assign value to initialize
    init(item: String = "", reminderIsOn: Bool = false, dueDate: Date = Date.now + 3600*24, notes: String = "", isCompleted: Bool = false) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
    }
}

extension ToDo {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: ToDo.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        //Add mock data
        container.mainContext.insert(ToDo(item: "Create SwiftData Lessons", reminderIsOn: true, dueDate: Date.now+3600*24, notes: "Now with IOS 16 & Xcode 18", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Create Xcode Lessons", reminderIsOn: true, dueDate: Date.now+3600*23, notes: "This is the 2nd lesson", isCompleted: true))
        container.mainContext.insert(ToDo(item: "Create Domino Lessons", reminderIsOn: true, dueDate: Date.now+3600*22, notes: "I want this to be 3d lesson", isCompleted: false))
        return container
    }
}
