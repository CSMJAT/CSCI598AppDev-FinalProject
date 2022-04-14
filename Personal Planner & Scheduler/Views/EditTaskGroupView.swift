//
//  EditTaskGroupView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/13/22.
//

import SwiftUI

struct EditTaskGroupView: View {
    @EnvironmentObject var userInfo: UserInformation
    var group: TaskGroup
    @Binding var selected: Bool
    @State private var groupID: TaskGroup.ID = TaskGroup(groupID: nil).id
    @State var name: String = "Untitled"
    @State var description: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("Task Group: ")
                TextField("Name", text: self.$name).onAppear {
                    name = group.name
                }
            }
            if group.id != userInfo.tasks.id {
                HStack{
                    Picker("Select Group", selection: $groupID){
                        ForEach(userInfo.allGroups.filter{item in return item.id != group.id}, id: \.id){ group in
                            Text(group.name)
                        }
                    }
                }
            }
            HStack{
                Text("Description: ")
                TextField("Description", text: self.$description).onAppear {
                    description = group.description
                }
            }
            HStack{
                if group.id != userInfo.tasks.id {
                    Button("Delete Group"){
                        userInfo.removeTaskGroup(taskGroupID: group.id)
                        self.selected = false
                    }
                }
                Button("Cancel"){
                    self.selected = false
                }
                Button("Save and Return"){
                    userInfo.recursiveGetTaskGroup(currGrp: userInfo.tasks, taskGroupID: group.id)?.name = name
                    userInfo.recursiveGetTaskGroup(currGrp: userInfo.tasks, taskGroupID: group.id)?.description = description
                    if group.id != userInfo.tasks.id {
                        userInfo.assignTaskGroupGroup(grpID: groupID, taskGroupID: group.id)
                    }
                    self.selected = false
                }
            }
        }
    }
}

struct EditTaskGroupView_Previews: PreviewProvider {
    static var previews: some View {
        let group = TaskGroup(groupID: nil)
        let selected = true
        EditTaskGroupView(group: group, selected: .constant(selected))
    }
}
