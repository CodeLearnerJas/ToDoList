//
//  ContentView.swift
//  ToDoList
//
//  Created by GuitarLearnerJas on 18/9/2024.
//

import SwiftUI

struct ToDoListView: View {
    var toDos = [
        "Learn SwiftUI",
        "Build App",
        "Change the world",
        "Go to the gym",
        "Bring the Awesome"
    ]
    var body: some View {
        NavigationStack{
            List {
                ForEach(toDos, id: \.self) { toDo in
                    NavigationLink{
                        DetailView(passedValue: toDo)
                    } label: {
                        Text(toDo)
                    }
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    ToDoListView()
}
