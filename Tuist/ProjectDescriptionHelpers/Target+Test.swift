import ProjectDescription

// MARK: Framework

public extension Target {
    
    static func testTarget(
        name: String,
        appBundleId: String,
        dependencies: [TargetDependency]
    ) -> Target {
        Target.target(
            name: name,
            destinations: .iOS,
            product: .unitTests,
            bundleId: appBundleId.lowercased(),
            infoPlist: .default,
            sources: [
                "Tests/**"
            ],
            dependencies: dependencies,
            settings: .settings(base: [
                // Явно указываем линковать системный фреймворк Testing
                "OTHER_LDFLAGS": ["-framework", "Testing"],
                // Для Swift 6
                "SWIFT_VERSION": "6.0"
            ])
        )
    }
}
