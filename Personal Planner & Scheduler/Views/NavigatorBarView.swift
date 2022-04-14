//
//  NavigatorBarView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/7/22.
//

import SwiftUI

struct NavigatorBarView: View {
    @StateObject var userInfo = UserInformation()
    @StateObject var navigator = NavigatorBar()
    //let menuView = MenuView()
    //let taskGroupView = TaskGroupView()
    //let scheduleView = ScheduleView()
    
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
        }.environmentObject(userInfo)
    }
    
    @ViewBuilder func getView(name: String) -> some View {
        switch name {
        case "Menu": MenuView() //menuView.self
        case "Tasks": TaskGroupView(group: userInfo.tasks).padding().frame(minWidth: 400, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity) //taskGroupView.self
        case "Schedule": ScheduleView() //scheduleView.self
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
