import DependencyHelper
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Presentation",
    destination: .iOS,
    product: .staticFramework,
    dependencies: [
        .Projects.domain
    ]
)
