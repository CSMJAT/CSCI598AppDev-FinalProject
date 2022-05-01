//
//  ScheduleView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        Text("View for creating schedules based off of tasks")
        //TODO: multiple schedule functionality?
        //TODO: select a task brings you to the EditTaskView for it? (or an inspector view?)
        //TODO: select a task gives you options for managing the task (i.e. start task, end task, delay task, etc)
        //TODO: download schedule functionality? (Maybe put this in menu?)
        .toolbar{
            ToolbarItem{Text("")} //Set to make the UI consistent across NavigatorBarWindows
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
