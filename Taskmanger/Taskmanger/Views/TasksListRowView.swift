//
//  TasksListRowView.swift
//  Taskmanger
//
//  Created by afnan althobaiti on 17/01/1445 AH.
//

import SwiftUI

struct TasksListRowView: View {
    
    let task: Task
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(task.status.color)
            Text(task.title)
        }
        
    }
}

//struct TasksListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        List {
//            TasksListRowView(task: .init(title: "Task", description: "", status: .done, priority: .high))
//        }
//        
//    }
//}
