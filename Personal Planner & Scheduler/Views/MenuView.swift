//
//  MenuView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var userInfo: UserInformation
    
    var body: some View {
        HStack{
            Text("Settings").font(.headline)
//            Toggle("Deadline", isOn: $hasDeadline).toggleStyle(.checkbox).onAppear{
//                if task.deadline != nil {
//                    hasDeadline = true
//                }
//            }
        }
        .toolbar{
            ToolbarItem{saveButton}
        }
    }
    
    var saveButton: some View {
        Button("Save"){
            return //TODO: get settings in UserInformation
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
