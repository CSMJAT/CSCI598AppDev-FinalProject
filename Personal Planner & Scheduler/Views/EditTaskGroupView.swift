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
            HStack{
                Text("Description: ")
                TextField("Description", text: self.$description).onAppear {
                    description = group.description
                }
            }
            HStack{
                Button("Cancel"){
                    self.selected = false
                }
                Button("Save and Return"){
                    userInfo.recursiveGetTaskGroup(currGrp: userInfo.tasks, taskGroupID: group.id)?.name = name
                    userInfo.recursiveGetTaskGroup(currGrp: userInfo.tasks, taskGroupID: group.id)?.description = description
                    self.selected = false
                }
            }
        }
    }
}

struct EditTaskGroupView_Previews: PreviewProvider {
    static var previews: some View {
        let group = TaskGroup()
        let selected = true
        EditTaskGroupView(group: group, selected: .constant(selected))
    }
}
