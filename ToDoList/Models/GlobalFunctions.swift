//
//  GlobalFunctions.swift
//  ToDoList
//
//  Created by GuitarLearnerJas on 23/9/2024.
//
//MARK: NOT IN USE
import Foundation
func purgeData() {
    let path = URL.documentsDirectory.appending(component: "toDos")
    let data = try? JSONEncoder().encode("")
    do {
        try data?.write(to: path)
    } catch {
    print("ERROR: could not save data:\(error.localizedDescription)")
    }
}
