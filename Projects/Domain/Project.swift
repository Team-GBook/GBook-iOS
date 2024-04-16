import DependencyHelper
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Domain",
    destination: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.core
    ]
)
