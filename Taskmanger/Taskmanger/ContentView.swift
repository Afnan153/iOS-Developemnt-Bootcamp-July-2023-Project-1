//
//  ContentView.swift
//  Taskmanger
//
//  Created by afnan althobaiti on 17/01/1445 AH.


//Requirment of project 1
// Tasks explore
// Task view
//Task creation
// Task deletion
// Task editing
// Task prioritization (LOW, MEDIUM, HIGH)
// Task status (Backlog, Todo, In-Progress, Done)
// Tasks filtration based on task-status
//Tasks searching based on task-title
// Tasks storing/loading locally  //using a @AppStoreg

import SwiftUI

struct ContentView: View {
    
    @AppStorage("tasks") var tasks: [Task] = []
    @State  var filteredTasks: [Task] = []
    
    @State  var searchText: String = ""
    @State  var status: Task.TaskStatus? = nil
    
    @State  var deleteAlert: Bool = false
    
    
    var listTasks: [Task] {
        if searchText.isEmpty && status == nil {
            return tasks
        } else {
            return filteredTasks
        }
    }
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(listTasks) { task in
                    NavigationLink(destination: TaskDetailsView(task: task)) {
                        TasksListRowView(task: task)
                            
                    }
                    .listRowBackground(task.priority.color)
                }
                .onDelete(perform: { _ in deleteAlert.toggle() })
                
                
            }
            .searchable(text: $searchText)
            .onChange(of: searchText, perform: { newValue in
                filteredTasks = tasks.filter {
                    $0.title.contains(searchText)
                }
            })
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button("Clear") {
                            status = nil
                        }
                        .disabled(status == nil)
                        Picker("Status", selection: $status) {
                            Text("Backlog").tag(Task.TaskStatus.backlog as Task.TaskStatus?)
                            Text("Todo").tag(Task.TaskStatus.todo as Task.TaskStatus?)
                            Text("Progress").tag(Task.TaskStatus.progress as Task.TaskStatus?)
                            Text("Done").tag(Task.TaskStatus.done as Task.TaskStatus?)
                        }
                        .onChange(of: status) { newValue in
                            filter()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NewTaskView()) {
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
            }
//            .alert("Confirm Delete", isPresented: $deleteAlert) {
//                Button("Cancel", role: .cancel, action: {})
//                Button("Yes", role: .destructive, action: delete)
//            }
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func filter() {
        filteredTasks = tasks.filter { task in
            task.status == status
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
           return result
    }
}
