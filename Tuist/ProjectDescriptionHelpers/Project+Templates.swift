import ProjectDescription

extension Project {
    public static func makeModule(
        name: String,
        destination: Destinations,
        organizationName: String = "com.GBook",
        infoPlist: InfoPlist = .default,
        product: Product,
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil
    ) -> Project {
        let moduleTarget: [Target] = [
            Target(
                name: name,
                destinations: destination,
                product: product,
                bundleId: "\(organizationName).\(name)",
                deploymentTargets: .iOS("15.0"),
                infoPlist: infoPlist,
                sources: sources,
                resources: resources,
                dependencies: dependencies
            )
        ]

        return .init(
            name: name,
            organizationName: organizationName,
            targets: moduleTarget,
            fileHeaderTemplate: nil
        )
    }
}

