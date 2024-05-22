import DependencyHelper
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Flow",
    destination: .iOS,
    product: .staticFramework,
    dependencies: [
        .Projects.data,
        .Projects.presentation
    ]
)
