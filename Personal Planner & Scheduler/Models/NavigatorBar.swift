//
//  NavigatorBar.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/7/22.
//

import Foundation
import SwiftUI

struct Tab: Identifiable {
    let id = UUID()
    let name: String
    let icon: Image
}

class NavigatorBar: ObservableObject {
    @Published var tabList: [Tab]
    @Published var selectedTab: UUID?
    
    init() {
        let menuTab = Tab(name: "Menu", icon: Image(systemName: "trash"))
        let taskGroupTab = Tab(name: "Tasks", icon: Image(systemName: "trash"))
        let scheduleTab = Tab(name: "Schedule", icon: Image(systemName: "trash"))
        tabList = [menuTab, taskGroupTab, scheduleTab]
        selectedTab = menuTab.id
    }
}
