import DependencyHelper
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Data",
    destination: .iOS,
    product: .staticFramework,
    dependencies: [
        .Modules.appNetwork,
        .Projects.domain
    ]
)
