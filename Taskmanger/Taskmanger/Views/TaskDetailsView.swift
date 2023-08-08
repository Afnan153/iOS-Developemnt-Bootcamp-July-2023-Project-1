//
//  TaskDetailsView.swift
//  Taskmanger
//
//  Created by afnan althobaiti on 17/01/1445 AH.
//

import SwiftUI

struct TaskDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("tasks") var tasks: [Task] = []
    
    let task: Task
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var priority: Task.TaskPriority = .low
    @State private var status: Task.TaskStatus = .backlog
    
    @State private var editing: Bool = false
    
    @State private var deleteAlert: Bool = false
    
    var body: some View {
        VStack {
            Form {
                if editing {
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
                } else {
                    LabeledContent("Title", value: task.title)
                    LabeledContent("Description", value: task.description)
                    LabeledContent("Priority", value: task.priority.title)
                    LabeledContent("Status", value: task.status.title)
                }
                
            }
            if editing {
                Button(action: save) {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding()
                        
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        editing.toggle()
                    }
                }) {
                    Image(systemName: "pencil")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { deleteAlert.toggle() }) {
                    Image(systemName: "trash")
                }
            }
        }
        .onAppear {
            title = task.title
            description = task.description
            priority = task.priority
            status = task.status
        }
        .alert("Confirm Delete", isPresented: $deleteAlert) {
            Button("Cancel", role: .cancel, action: {})
            Button("Yes", role: .destructive, action: delete)
        }
    }
    
    private func save() {
        guard let index = tasks.firstIndex(where: { t in
            t.id == task.id
        }) else {
            return
        }
        
        let updatedTask = Task(id: task.id ,title: title, description: description, status: status, priority: priority)
        
        tasks[index] = updatedTask
        editing.toggle()
    }
    
    private func delete() {
        guard let index = tasks.firstIndex(where: { t in
            t.id == task.id
        }) else {
            return
        }
        
        tasks.remove(at: index)
        dismiss()
    }
    
}

//struct TaskDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskDetailsView(task: .init(title: "task", description: "", status: .backlog, priority: .high))
//    }
//}
