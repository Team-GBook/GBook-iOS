import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies([
        // Moya
        .remote(
            url: "https://github.com/Moya/Moya.git",
            requirement: .upToNextMajor(from: "15.0.3")
        ),
        // RxSwift
        .remote(url: "https://github.com/ReactiveX/RxSwift",
                requirement: .upToNextMajor(from: "6.5.0")),
        // SnapKit
        .remote(
            url: "https://github.com/SnapKit/SnapKit.git",
            requirement: .upToNextMajor(from: "5.0.1")
        ),
        // Then
        .remote(
            url: "https://github.com/devxoul/Then.git",
            requirement: .upToNextMajor(from: "3.0.0")
        ),
        // KeychainSwift
        .remote(
            url: "https://github.com/evgenyneu/keychain-swift.git",
            requirement: .upToNextMajor(from: "20.0.0")
        ),
        // RxFlow
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxFlow.git",
            requirement: .upToNextMajor(from: "2.13.0")
        ),
        // Kingfisher
        .remote(
            url: "https://github.com/onevcat/Kingfisher.git",
            requirement: .upToNextMajor(from: "7.4.1")
        ),
        // RxGesture
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxGesture.git",
            requirement: .upToNextMajor(from: "4.0.0")
        ),
        //Xquare_DesignSystem
        .remote(
            url:"https://github.com/team-xquare/xquare-design-system-iOS",
            requirement: .upToNextMajor(from: "0.0.4")
        )
    ]),
    platforms: [.iOS]
)
