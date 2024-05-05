import ProjectDescription

public extension TargetDependency {
    struct Modules {}
    struct Projects {}
}

public extension TargetDependency.Projects {
    static let core = project(name: "Core")
    static let presentation = project(name: "Presentation")
    static let data = project(name: "Data")
    static let domain = project(name: "Domain")
    
    static func project(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Projects/\(name)")
        )
    }
}

public extension TargetDependency.Modules {
    static let thirdPartyLib = module(name: "ThirdPartyLib")
    static let appNetwork = module(name: "AppNetwork")

    static func module(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Projects/Modules/\(name)")
        )
    }
}
