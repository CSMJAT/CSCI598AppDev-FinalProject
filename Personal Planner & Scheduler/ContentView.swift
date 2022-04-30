//
//  ContentView.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 3/31/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var document: PersistData
    
    var body: some View {
        NavigatorBarView(userInfo: document.userInfo)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
