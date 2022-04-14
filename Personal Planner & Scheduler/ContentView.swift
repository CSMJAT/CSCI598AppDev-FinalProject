//
//  ContentView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import SwiftUI

struct ContentView: View {
    @State var info = UserInformation()
    var body: some View {
        NavigatorBarView(userInfo: info)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
