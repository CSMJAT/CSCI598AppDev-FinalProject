//
//  UserInformation.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/7/22.
//

import Foundation

class UserInformation: ObservableObject {
    var tasks = TaskGroup()
    var allTasks: [Task] = []
    var allGroups: [TaskGroup] = []
    
    init() {
        tasks.name = "All Tasks"
        tasks.description = "Contains all tasks and groups."
        allGroups.append(tasks)
    }
    
    func addNewTask(inGroup group: TaskGroup.ID) -> Task {
        let newTask = Task(groupID: group)
        recursiveAddTask(currGrp: tasks, groupID: group, task: newTask)
        allTasks.append(newTask)
        return newTask
    }
    
    func recursiveAddTask(currGrp: TaskGroup, groupID id: TaskGroup.ID, task: Task){
        if currGrp.id == id {
            currGrp.addTask(task: task)
            return
        }
        for group in currGrp.groups {
            recursiveAddTask(currGrp: group, groupID: id, task: task)
        }
    }
    
    func assignTaskGroup(grpID: TaskGroup.ID?, taskID: Task.ID){
        guard let task = recursiveGetTask(currGrp: tasks, taskID: taskID) else {return}
        if task.groupID == grpID { return }
        var tgID = tasks.id
        if grpID != nil {tgID = grpID!}
        guard let tg = recursiveGetTaskGroup(currGrp: tasks, taskGroupID: tgID) else {return}
        tg.addTask(task: task)
        guard let tg2 = recursiveGetTaskGroup(currGrp: tasks, taskGroupID: task.groupID) else {return}
        tg2.removeTask(task: task)
        task.groupID = tgID
    }
    
    func recursiveGetTask(currGrp: TaskGroup, taskID id: Task.ID) -> Task? {
        for task in currGrp.tasks {
            if task.id == id {
                return task
            }
        }
        var taskResult: Task? = nil
        for group in currGrp.groups {
            taskResult = recursiveGetTask(currGrp: group, taskID: id)
            if taskResult != nil {
                return taskResult
            }
        }
        return taskResult
    }
    
    func addNewTaskGroup(inGroup group: TaskGroup.ID) -> TaskGroup {
        let newTaskGroup = TaskGroup()
        recursiveAddTaskGroup(currGrp: tasks, groupID: group, taskGroup: newTaskGroup)
        allGroups.append(newTaskGroup)
        return newTaskGroup
    }
    
    private func recursiveAddTaskGroup(currGrp: TaskGroup, groupID id: TaskGroup.ID, taskGroup: TaskGroup){
        if currGrp.id == id {
            currGrp.addTaskGroup(taskGroup: taskGroup)
            return
        }
        for group in currGrp.groups {
            recursiveAddTaskGroup(currGrp: group, groupID: id, taskGroup: taskGroup)
        }
    }
    
    func recursiveGetTaskGroup(currGrp: TaskGroup, taskGroupID id: TaskGroup.ID) -> TaskGroup? {
        if currGrp.id == id {
            return currGrp
        }
        var taskGrpResult: TaskGroup? = nil
        for group in currGrp.groups {
            taskGrpResult = recursiveGetTaskGroup(currGrp: group, taskGroupID: id)
            if taskGrpResult != nil {
                return taskGrpResult
            }
        }
        return taskGrpResult
    }
    
    func getTree(group: TaskGroup) -> TreeDisplay {
        var branch = TreeDisplay(name: group.name, task: false, taskGroupID: group.id)
        var children: [TreeDisplay] = []
        for task in group.tasks {
            children.append(TreeDisplay(name: task.name, taskID: task.id))
        }
        for group in group.groups {
            children.append(getTree(group: group))
        }
        if !children.isEmpty {
            branch.children = children
        }
        return branch
    }

    
}
