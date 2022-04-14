//
//  TaskGroup.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import Foundation

class TaskGroup: Identifiable {
    var id = UUID()
    
    var name: String = "Untitled Group"
    var description: String = ""
    var tasks: [Task] = []
    var groups: [TaskGroup] = []
    
    var groupID: TaskGroup.ID? = nil
    
    init(groupID: TaskGroup.ID?){
        self.groupID = groupID
    }
    
    func addTask(task: Task) {
        tasks.append(task)
    }
    
    func removeTask(task: Task) {
        tasks.removeAll{ otherTask in
            return otherTask.id == task.id
        }
    }
    
    func addTaskGroup(taskGroup: TaskGroup) {
        groups.append(taskGroup)
    }
    
    func removeTaskGroup(taskGroup: TaskGroup) {
        groups.removeAll{ otherGroup in
            return otherGroup.id == taskGroup.id
        }
    }
    //TODO: Group statistics?
}
