import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "AppFlow",
    destination: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.data,
        .Project.presentation
    ]
)
