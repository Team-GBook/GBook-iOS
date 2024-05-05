import SwiftUI
import Presentation

@main
struct GBookApp: App {
    @ObservedObject var sceneState = SceneState()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView()
                    .environmentObject(sceneState)
            }
        }
    }
}
