import Combine
import SwiftUI

public final class SceneState: ObservableObject {
    public init() { }

    public enum Scene {
        case onboarding
        case login
        case emailInput
        case emailCertification
        case profileSet
        case signup
        case main
    }
    @Published public var scene = Scene.onboarding
}
