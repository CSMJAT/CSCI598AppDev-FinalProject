//
//  Task.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import Foundation

class Task: Identifiable, ObservableObject, Codable {
    
    var id = UUID()
    
    var name: String = "Untitled Task"
    
    enum taskType: String, Codable, CaseIterable {
        case scheduled = "Scheduled"
        case deadline = "Deadline"
        case neither = "Neither"
    }
    var type: taskType = .neither
    
    //Variables for scheduled times:
    var startTime: Date? = nil
    var endTime: Date? = nil
    //Variable for deadline
    var deadline: Date? = nil
    
    var notes: String = ""
    var estimatedLength: Double = 0.0
    
    var groupID: TaskGroup.ID
    
    //TODO: Initializer(s) for creating tasks
    init(groupID: TaskGroup.ID){
        self.groupID = groupID
    }
    
    //TODO: functions for getting info on tasks
}
