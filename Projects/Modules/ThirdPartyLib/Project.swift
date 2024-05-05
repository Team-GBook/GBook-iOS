import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "ThirdPartyLib",
    destination: .iOS,
    product: .staticFramework,
    dependencies: TargetDependency.SPM.all
)
