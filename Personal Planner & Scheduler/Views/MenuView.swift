//
//  MenuView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        Text("View for menu settings")
        //TODO: calendar settings?
        //TODO: save functionality?
        //TODO: break options?
        .toolbar{
            ToolbarItem{Text("")} //Set to make the UI consistent across NavigatorBarWindows
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
