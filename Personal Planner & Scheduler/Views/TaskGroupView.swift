//
//  TaskGroupView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import SwiftUI

struct TaskGroupView: View {
    @EnvironmentObject var userInfo: UserInformation
    var group: TaskGroup
    @State var selectedTask: Task? = nil
    @State var selectedTaskGroup: TaskGroup? = nil
    @State var selectedT: Bool = false
    @State var selectedTG: Bool = false
    
    var body: some View {
        if !selectedT && !selectedTG {
            VStack{
                TreeView(branch: self.userInfo.getTree(group: userInfo.tasks), expanded: true, selectedT: $selectedT, selectedTG: $selectedTG, selectedTask: $selectedTask, selectedTaskGroup: $selectedTaskGroup)
            }
            .toolbar {
                ToolbarItem{addTaskButton}
                ToolbarItem{addGroupButton}
            }
        } else if selectedT {
            EditTaskView(task: selectedTask!, selected: $selectedT).padding()
        } else if selectedTG {
            EditTaskGroupView(group: selectedTaskGroup!, selected: $selectedTG).padding()
        } else {
            EmptyView()
        }
    }
    
    var addTaskButton: some View {
        Button("Add New Task"){
            selectedTask = userInfo.addNewTask(inGroup: group.id)
            selectedT = true
        }
    }
    
    var addGroupButton: some View {
        Button("Add New Group"){
            selectedTaskGroup = userInfo.addNewTaskGroup(inGroup: group.id)
            selectedTG = true
        }
    }
}

struct TaskGroupView_Previews: PreviewProvider {
    static var previews: some View {
        let group = TaskGroup(groupID: nil)
        TaskGroupView(group: group)
    }
}
