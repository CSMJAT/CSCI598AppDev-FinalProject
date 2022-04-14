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
    @State var notes: String = ""
    @State var hasDeadline: Bool = false
    
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
                }
            }
            Toggle("Deadline", isOn: $hasDeadline).toggleStyle(.checkbox).onAppear{
                if task.deadline != nil {
                    hasDeadline = true
                }
            }
            if hasDeadline {
                GroupBox {
                    Text("Deadline")
                    HStack{
                        DatePicker("Date", selection: $deadline, displayedComponents: .date).onAppear{
                            if task.deadline != nil {
                                deadline = task.deadline!
                            }
                        }//.datePickerStyle(.graphical)
                        Divider()
                        DatePicker("Time", selection: $deadline, displayedComponents: .hourAndMinute).onAppear{
                            if task.deadline != nil {
                                deadline = task.deadline!
                            }
                        }
                    }
                }
            }
            HStack{
                Text("Notes: ")
                TextField("Notes", text: self.$notes).onAppear {
                    notes = task.notes
                }
            }
            HStack{
                Button("Delete Task"){
                    userInfo.removeTask(taskID: task.id)
                    self.selected = false
                }
                Button("Cancel"){
                    self.selected = false
                }
                Button("Save and Return"){
                    userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.name = name
                    userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.notes = notes
                    userInfo.assignTaskGroup(grpID: groupID, taskID: task.id)
                    if hasDeadline {
                        userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.deadline = deadline
                    } else {
                        userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.deadline = nil
                    }
                    self.selected = false
                }
            }
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
