//
//  Task.swift
//  Taskmanger
//
//  Created by afnan althobaiti on 17/01/1445 AH.
//

import SwiftUI

//Task prioritization (LOW, MEDIUM, HIGH)
//Task status (Backlog, Todo, In-Progress, Done)
//Tasks filtration based on task-status
//Tasks searching based on task-title
struct Task: Identifiable, Codable {
    
    enum TaskPriority: Codable {
        case low
        case medium
        case high
        
        var color: Color {
            switch self {
            case .low: return .clear
            case .medium: return .orange.opacity(0.25)
            case .high: return .pink.opacity(0.25)
            }
        }
        
        var title: String {
            switch self {
            case .low: return "Low"
            case .medium: return "medium"
            case .high: return "high"
            }
        }
    }
    
    enum TaskStatus: Codable {
        case backlog
        case todo
        case progress
        case done
        
        var color: Color {
            switch self {
            case .backlog: return .black
            case .todo: return .orange
            case .progress: return .blue
            case .done: return .green
            }
        }
        
        var title: String {
            switch self {
            case .backlog: return "Backlog"
            case .todo: return "Todo"
            case .progress: return "Progress"
            case .done: return "Done"
            }
        }
    }
    
    let id: UUID
    let title: String
    let description: String
    let status: TaskStatus
    let priority: TaskPriority
}
