import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "AppNetwork",
    destination: .iOS,
    product: .staticFramework,
    dependencies: [
        .Projects.core
    ]
)
