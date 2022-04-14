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
    @State private var groupID: TaskGroup.ID = TaskGroup().id
    @Binding var selected: Bool
    @State var name: String = "Untitled"
    @State var notes: String = ""
    
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
            HStack{
                Text("Notes: ")
                TextField("Notes", text: self.$notes).onAppear {
                    notes = task.notes
                }
            }
            HStack{
                Button("Cancel"){
                    self.selected = false
                }
                Button("Save and Return"){
                    userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.name = name
                    userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)?.notes = notes
                    userInfo.assignTaskGroup(grpID: groupID, taskID: task.id)
                    self.selected = false
                }
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        let tg = TaskGroup()
        let task = Task(groupID: tg.id)
        let selected = true
        EditTaskView(task: task, selected: .constant(selected))
    }
}
