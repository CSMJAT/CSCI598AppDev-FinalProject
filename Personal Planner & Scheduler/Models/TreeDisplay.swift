//
//  TreeDisplay.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/13/22.
//

import Foundation

struct TreeDisplay: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var children: [TreeDisplay]? = nil
    //TODO: get icons for task vs group in TaskGroupView working
    var task: Bool = true
    var taskID: Task.ID? = nil
    var taskGroupID: TaskGroup.ID? = nil
}
