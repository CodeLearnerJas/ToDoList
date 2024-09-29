//
//  ContentView.swift
//  ToDoList
//
//  Created by GuitarLearnerJas on 18/9/2024.
//
//Logic explain:
/* When the user selects a sorting option in the Picker, the selected value is passed to sortSelection. This triggers the init(sortSelection: SortOption) initializer of the SortedToDoList view. The initializer uses the sortSelection value to match one of the cases in the switch statement and then modifies the Query for fetching or sorting the toDos accordingly.
 */
import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
    case asEntered = "As Entered"
    case alphabetical = "A-Z"
    case chronological = "Date"
    case completed = "Not Done"
}
struct SortedToDoList: View {
    @Query var toDos: [ToDo]
    @Environment(\.modelContext) var modelContext
    let sortSelection: SortOption
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        switch self.sortSelection {
        case .asEntered:
            _toDos = Query()
        case .alphabetical:
            _toDos = Query(sort: \.item, animation: .easeInOut)
        case .chronological:
            _toDos = Query(sort: \.dueDate, animation: .easeInOut)
        case .completed:
            _toDos = Query(filter: #Predicate{ $0.isCompleted == false }, animation: .easeInOut)
        }
    }
    
    var body: some View {
        List {
            ForEach(toDos) { toDo in
                VStack (alignment: .leading){
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                            }
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                    }
                    .font(.title2)
                    HStack {
                        Text(toDo.dueDate.formatted(date: .abbreviated,time: .shortened))
                            .foregroundStyle(.secondary)
                        if(toDo.reminderIsOn) {
                            Image (systemName: "calendar.badge.clock")
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                }
                .swipeActions {
                    Button("Delete", role: .destructive) {
                        modelContext.delete(toDo)
                        guard let _ = try? modelContext.save() else {
                            print("ERROR: Could not save changes")
                            return
                        }
                    }
                }
            }
            
            //MARK: Alternative deleting using onDelete
            //            .onDelete { indexSet in
            //                indexSet.forEach { modelContext.delete(self.toDos[$0]) }
            //                guard let _ = try? modelContext.save() else {
            //                    print("ERROR: Could not save changes")
            //                    return
            //                }
            //            }
        }
        .listStyle(.plain)
    }
}
struct ToDoListView: View {
    
    @State private var sheetIsPresented: Bool = false
    @State private var sortSelection: SortOption = .asEntered
    
    var body: some View {
        NavigationStack{
            SortedToDoList(sortSelection: sortSelection) //SortedToDoList View
                .navigationTitle("To Do List")
                .navigationBarTitleDisplayMode(.automatic)
                .sheet(isPresented: $sheetIsPresented) {
                    NavigationStack {
                        DetailView(toDo: ToDo())
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            sheetIsPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Picker("", selection: $sortSelection) {
                            ForEach(SortOption.allCases, id: \.self) { sortOrder in
                                Text(sortOrder.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ToDoListView()
        .modelContainer(ToDo.preview)
}
