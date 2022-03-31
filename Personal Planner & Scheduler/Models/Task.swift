//
//  Task.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import Foundation

class Task: Identifiable {
    var id = UUID()
    
    private var name: String = ""
    //var for scheduled times
    private var staticLength: Bool = false //TODO: change this to an enum maybe?
    //var for estimated length
    private var deadline: Date? = nil
    private var notes: String = ""
    
    //TODO: Initializer(s) for creating tasks
    
    //TODO: functions for modifying & getting info on tasks
}
