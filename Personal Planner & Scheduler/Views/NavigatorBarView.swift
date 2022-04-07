//
//  NavigatorBarView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/7/22.
//

import SwiftUI

struct NavigatorBarView: View {
    @StateObject var navigator = NavigatorBar()
    let menuView = MenuView()
    let taskGroupView = TaskGroupView()
    let scheduleView = ScheduleView()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(navigator.tabList){ tab in
                    NavigationLink(tab.name, tag: tab.id, selection: $navigator.selectedTab){
                        getView(name: tab.name)
                    }
                }
            }.listStyle(.sidebar)
            Text("Select a Tab")
        }
    }
    
    @ViewBuilder func getView(name: String) -> some View {
        switch name {
        case "Menu": menuView.self
        case "Tasks": taskGroupView.self
        case "Schedule": scheduleView.self
        default:
            Text("Select a Tab")
        }
    }
}

struct NavigatorBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorBarView()
    }
}
