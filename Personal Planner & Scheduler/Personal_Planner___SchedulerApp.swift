//___FILEHEADER___

import SwiftUI

@main
struct Personal_Planner___SchedulerApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: {PersistData()}) { file in
            ContentView()
        }
    }
}
