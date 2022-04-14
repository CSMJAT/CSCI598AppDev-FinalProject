//
//  Task.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import Foundation

class Task: Identifiable, ObservableObject {
    
    var id = UUID()
    
    var name: String = "Untitled Task"
    //var for scheduled times
    var staticLength: Bool = false //TODO: change this to an enum maybe?
    //var for estimated length
    var deadline: Date? = nil
    var notes: String = ""
    
    var groupID: TaskGroup.ID
    
    //TODO: Initializer(s) for creating tasks
    init(groupID: TaskGroup.ID){
        self.groupID = groupID
    }
    
    //TODO: functions for modifying & getting info on tasks
}
