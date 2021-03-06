//
//  TreeDisplay.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/13/22.
//

import Foundation
import SwiftUI

struct TreeDisplay: Hashable, Identifiable {
    var id = UUID()
    var expanded: Bool = false
    var name: String
    var children: [TreeDisplay]? = nil
    var task: Bool = true
    var taskID: Task.ID? = nil
    var taskGroupID: TaskGroup.ID? = nil
}
