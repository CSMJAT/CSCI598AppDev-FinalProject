//
//  ScheduleView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var userInfo: UserInformation
    @State var sort: sortType = .duedate
    enum sortType: String, CaseIterable {
        case alphabetical = "Alphabetical"
        case duedate = "Due Date"
        case bygroup = "Group"
    }
    @State var selectedTask: Task? = nil
    @State var selectedT: Bool = false
    
    var body: some View {
        if !selectedT {
            VStack{
                Picker("Task Type", selection: $sort){
                    ForEach(sortType.allCases, id: \.self){ sType in
                        Text(sType.rawValue).tag(sType)
                    }
                }
                switch (sort) {
                case .alphabetical:
                    ForEach(userInfo.allTasks.sorted{$0.name < $1.name}){ task in
                        HStack{
                            Image(systemName: "square.and.pencil")
                            Button(task.name){
                                selectedTask = userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)
                                selectedT = true
                            }.buttonStyle(.borderless)
                        }
                    }
                case .duedate:
                    ForEach(userInfo.allTasks.sorted{
                        var date0: Date = .distantFuture
                        var date1: Date = .distantFuture
                        switch ($0.type){
                        case .deadline:
                            if $0.deadline != nil {
                                date0 = $0.deadline!
                            }
                        case .scheduled:
                            if $0.startTime != nil {
                                date0 = $0.startTime!
                            }
                        case .neither:
                            break
                        }
                        switch ($1.type){
                        case .deadline:
                            if $1.deadline != nil {
                                date1 = $1.deadline!
                            }
                        case .scheduled:
                            if $1.startTime != nil {
                                date1 = $1.startTime!
                            }
                        case .neither:
                            break
                        }
                        print("\($0.name) due at \(String(describing: date0)) < \($1.name) due at \(String(describing: date1)) is \(date0 < date1)")
                        return date0 < date1
                    }){ task in
                        HStack{
                            Image(systemName: "square.and.pencil")
                            Button(task.name){
                                selectedTask = userInfo.recursiveGetTask(currGrp: userInfo.tasks, taskID: task.id)
                                selectedT = true
                            }.buttonStyle(.borderless)
                        }
                    }
                case .bygroup:
                    Text("Implement by group functionality")
                }
            }
            .toolbar{
                ToolbarItem{Text("")} //Set to make the UI consistent across NavigatorBarWindows
            }
        } else if selectedT {
            EditTaskView(task: selectedTask!, selected: $selectedT).padding()
        } else {
            EmptyView()
                .toolbar{
                    ToolbarItem{Text("")} //Set to make the UI consistent across NavigatorBarWindows
                }
        }
        
        //TODO: multiple schedule functionality?
        //TODO: select a task brings you to the EditTaskView for it? (or an inspector view?)
        //TODO: select a task gives you options for managing the task (i.e. start task, end task, delay task, etc)
        //TODO: download schedule functionality? (Maybe put this in menu?)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
