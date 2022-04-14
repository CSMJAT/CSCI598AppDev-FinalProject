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
//        NavigationView{
//            VStack{
//                NavigationLink(group.name){
//                    EditTaskGroupView()
//                }.buttonStyle(.plain)
//                ForEach(group.tasks, id: \.id){ task in
//                    GroupBox{
//                        NavigationLink(task.name){
//                            EditTaskView(task: task).padding()
//                        }.buttonStyle(.borderless)
//                    }
//                }
//                Button("Add New Task"){
//                    selectedTask = userInfo.addTask(inGroup: group.id)
//                }
//            }
//            Text("Select a task or task group.")
//        }
        if !selectedT && !selectedTG {
//            List{
//                Button(group.name){
//                    selectedTaskGroup = group
//                    selectedTG = true
//                }.buttonStyle(.plain)
//                ForEach(group.tasks, id: \.id){ task in
//                    GroupBox{
//                        Button(task.name){
//                            selectedTask = task
//                            selectedT = true
//                        }.buttonStyle(.borderless)
//                    }
//                }
//                Button("Add New Task"){
//                    selectedTask = userInfo.addNewTask(inGroup: group.id)
//                    selectedT = true
//                }
//                ForEach(group.groups, id: \.id){ group in
//                    TaskGroupView(group: group)
//                }
//                Button("Add New Task Group"){
//                    selectedTaskGroup = userInfo.addNewTaskGroup(inGroup: group.id)
//                    selectedTG = true
//                }
//            }.listStyle(.sidebar)
            VStack{
                OutlineGroup(self.userInfo.getTree(group: userInfo.tasks), children: \.children) { taskItem in
                    if taskItem.task {
                        Button(taskItem.name){
                            selectedTask = userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: taskItem.taskID!)
                            selectedT = true
                        }.buttonStyle(.borderless)
                    } else {
                        Button(taskItem.name){
                            selectedTaskGroup = userInfo.recursiveGetTaskGroup(currGrp: userInfo.tasks, taskGroupID: taskItem.taskGroupID!)
                            selectedTG = true
                        }.buttonStyle(.plain)
                    }
                }
                HStack{
                    Button("Add New Task"){
                        selectedTask = userInfo.addNewTask(inGroup: group.id)
                        selectedT = true
                    }
                    Button("Add New Task Group"){
                        selectedTaskGroup = userInfo.addNewTaskGroup(inGroup: group.id)
                        selectedTG = true
                    }
                }
            }
            
        } else if selectedT {
            EditTaskView(task: selectedTask!, selected: $selectedT).padding()
        } else if selectedTG {
            EditTaskGroupView(group: selectedTaskGroup!, selected: $selectedTG).padding()
        } else {
            EmptyView()
        }
    }
}

struct TaskGroupView_Previews: PreviewProvider {
    static var previews: some View {
        let group = TaskGroup()
        TaskGroupView(group: group)
    }
}
