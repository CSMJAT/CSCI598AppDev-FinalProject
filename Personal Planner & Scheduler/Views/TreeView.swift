//
//  TreeView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/30/22.
//

import SwiftUI

struct TreeView: View {
    @EnvironmentObject var userInfo: UserInformation
    var branch: TreeDisplay
    @State var expanded: Bool
    @Binding var selectedT: Bool
    @Binding var selectedTG: Bool
    @Binding var selectedTask: Task?
    @Binding var selectedTaskGroup: TaskGroup?
    
    var body: some View {
        if branch.task {
            HStack{
                Image(systemName: "square.and.pencil")
                Button(branch.name){
                    selectedTask = userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: branch.taskID!)
                    selectedT = true
                }.buttonStyle(.borderless)
            }
        } else {
            DisclosureGroup(isExpanded: $expanded, content: {
                if expanded {
                    if branch.children != nil {
                        ForEach(branch.children!){ child in
                            TreeView(branch: child, expanded: child.expanded, selectedT: $selectedT, selectedTG: $selectedTG, selectedTask: $selectedTask, selectedTaskGroup: $selectedTaskGroup).padding(.leading,20)
                        }
                    } else {
                        Text("Empty").italic().foregroundColor(.secondary)
                    }
                }
            }, label: {
                HStack{
                    Image(systemName: "folder")
                    Button(branch.name){
                        selectedTaskGroup = userInfo.recursiveGetTaskGroup(currGrp: userInfo.tasks, taskGroupID: branch.taskGroupID!)
                        selectedTG = true
                    }.buttonStyle(.plain)
                }
            })
        }
    }
}

struct TreeView_Previews: PreviewProvider {
    static var previews: some View {
        TreeView(branch: TreeDisplay(name: ""), expanded: true, selectedT: .constant(false), selectedTG: .constant(false), selectedTask: .constant(nil), selectedTaskGroup: .constant(nil))
    }
}
