//
//  TaskView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import SwiftUI

struct EditTaskView: View {
    @EnvironmentObject var userInfo: UserInformation
    var task: Task
    @State private var groupID: TaskGroup.ID = TaskGroup(groupID: nil).id
    @Binding var selected: Bool
    @State var name: String = "Untitled"
    @State private var deadline = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State var notes: String = ""
    @State var taskType: Task.taskType = .neither
    
    var body: some View {
        VStack{
            HStack{
                Text("Task: ")
                TextField("Name", text: self.$name).onAppear {
                    name = task.name
                }
            }
            HStack{
                Picker("Select Group", selection: $groupID){
                    ForEach(userInfo.allGroups, id: \.id){ group in
                        Text(group.name)
                    }
                }.onAppear{
                    groupID = task.groupID
                }
            }
            HStack {
                Picker("Task Type", selection: $taskType){
                    ForEach(Task.taskType.allCases, id: \.self){ tType in
                        Text(tType.rawValue).tag(tType)
                    }
                }.onAppear{
                    taskType = task.type
                }
            }
//            Toggle("Deadline", isOn: $hasDeadline).toggleStyle(.checkbox).onAppear{
//                if task.deadline != nil {
//                    hasDeadline = true
//                }
//            }
            switch(taskType){
            case .deadline:
                GroupBox {
                    Text("Deadline")
                    DatePicker("Date", selection: $deadline, displayedComponents: .date).onAppear{
                        if task.deadline != nil {
                            deadline = task.deadline!
                        }
                    }//.datePickerStyle(.graphical)
                    DatePicker("Time", selection: $deadline, displayedComponents: .hourAndMinute).onAppear{
                        if task.deadline != nil {
                            deadline = task.deadline!
                        }
                    }
                }
            case .scheduled:
                GroupBox{
                    HStack{
                        Text("Date")
                        DatePicker("Date", selection: $startTime, displayedComponents: .date).onAppear{
                            if task.startTime != nil {
                                startTime = task.startTime!
                            }
                        }
                        Divider()
                        VStack{
                            Text("Start Time")
                            DatePicker("Time", selection: $startTime, displayedComponents: .hourAndMinute).onAppear{
                                if task.startTime != nil {
                                    startTime = task.startTime!
                                }
                            }
                            Text("End Time")
                            DatePicker("Time", selection: $endTime, displayedComponents: .hourAndMinute).onAppear{
                                if task.endTime != nil {
                                    endTime = task.endTime!
                                }
                            }
                        }
                    }
                }
            case .neither:
                EmptyView()
            }
            HStack{
                Text("Notes: ")
                TextField("Notes", text: self.$notes).onAppear {
                    notes = task.notes
                }
            }
            .toolbar{
                ToolbarItem{saveTaskButton}
                ToolbarItem{cancelTaskButton}
                ToolbarItem{deleteTaskButton}
            }
        }
    }
    var deleteTaskButton: some View {
        Button("Delete"){
            userInfo.removeTask(taskID: task.id)
            self.selected = false
        }
    }
    var cancelTaskButton: some View {
        Button("Cancel"){
            self.selected = false
        }
    }
    var saveTaskButton: some View {
        Button("Save"){
            userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.name = name
            userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.notes = notes
            userInfo.assignTaskGroup(grpID: groupID, taskID: task.id)
            switch (taskType){
            case .deadline:
                userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.deadline = deadline
            case .scheduled:
                userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.startTime = startTime
                userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.endTime = endTime
            case .neither:
                break
            }
            userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.type = taskType
            self.selected = false
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        let tg = TaskGroup(groupID: nil)
        let task = Task(groupID: tg.id)
        let selected = true
        EditTaskView(task: task, selected: .constant(selected))
    }
}
