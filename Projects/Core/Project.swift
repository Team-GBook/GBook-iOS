import DependencyHelper
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Core",
    destination: .iOS,
    product: .staticFramework,
    dependencies: [
        .Module.thirdPartyLib
    ]
)
