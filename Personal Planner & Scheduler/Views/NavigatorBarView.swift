//
//  NavigatorBarView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/7/22.
//

import SwiftUI

struct NavigatorBarView: View {
    @StateObject var userInfo: UserInformation
    @StateObject var navigator = NavigatorBar()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(navigator.tabList){ tab in
                    HStack{
                        tab.icon
                        NavigationLink(tab.name, tag: tab.id, selection: $navigator.selectedTab){
                            getView(name: tab.name)
                        }
                    }
                }
            }.listStyle(.sidebar)
            ScrollView{
                Text("Select a Tab")
            }
        }.environmentObject(userInfo)
    }
    
    @ViewBuilder func getView(name: String) -> some View {
        switch name {
        //case "Menu": ScrollView{MenuView()}
        case "Tasks": ScrollView{TaskGroupView(group: userInfo.tasks).padding().frame(minWidth: 400, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)}
        case "Schedule": ScrollView{ScheduleView()}
        default:
            Text("Select a Tab")
        }
    }
}

struct NavigatorBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorBarView(userInfo: UserInformation())
    }
}
