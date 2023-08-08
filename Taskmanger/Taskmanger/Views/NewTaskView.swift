//
//  NewTaskView.swift
//  Taskmanger
//
//  Created by afnan althobaiti on 17/01/1445 AH.
//

import SwiftUI

struct NewTaskView: View {
    
    @AppStorage("tasks") var tasks: [Task] = []
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var priority: Task.TaskPriority = .low
    @State private var status: Task.TaskStatus = .backlog
    
    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description, axis: .vertical)
                    .lineLimit(5, reservesSpace: true)
                Picker("Priority", selection: $priority) {
                    Text("Low").tag(Task.TaskPriority.low)
                    Text("Medium").tag(Task.TaskPriority.medium)
                    Text("High").tag(Task.TaskPriority.high)
                }
                .pickerStyle(.menu)
                
                Picker("Status", selection: $status) {
                    Text("Backlog").tag(Task.TaskStatus.backlog)
                    Text("Todo").tag(Task.TaskStatus.todo)
                    Text("Progres").tag(Task.TaskStatus.progress)
                    Text("Done").tag(Task.TaskStatus.done)
                }
                .pickerStyle(.menu)
            }
            
            Button(action: save) {
                Text("Add")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding()
                    
            }
        }
        
    }
    
        func save() {
        let task = Task(id: UUID(),
            title: title, description: description,
             status: .backlog,
             priority: priority)
             tasks.append(task)
              dismiss()
    }
}

//struct NewTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskView()
//    }
//}
