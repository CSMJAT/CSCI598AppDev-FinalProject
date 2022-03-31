//
//  TaskGroup.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import Foundation

class TaskGroup: Identifiable {
    var id = UUID()
    
    private var name: String = ""
    var tasks: [Task] = []
    
    //TODO: Group statistics?
}
