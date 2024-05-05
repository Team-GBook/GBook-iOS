import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project(
    name: "GBook-iOS",
    organizationName: organizationName,
    targets: [
        Target(
            name: "GBook-iOS",
            destinations: .iOS,
            product: .app,
            bundleId: "\(organizationName).iOS",
            deploymentTargets: DeploymentTargets(iOS: "15.0"),
            infoPlist: .file(path: "SupportingFile/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .Projects.data,
                .Projects.presentation
            ]
        )
    ]
)
