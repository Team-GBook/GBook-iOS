import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "DesignSystem",
    destination: .iOS,
    product: .staticFramework,
    dependencies: [
        .Projects.core
    ],
    resources: ["Resources/**"]
)
