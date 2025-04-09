//import ProjectDescription
//
//// MARK: Framework
//
//public extension Target {
//    
//    static func appTarget(
//        name: String,
//        bundleId: String,
//        brandName: String,
//        appFolderName: String,
//        deploymentTargets: DeploymentTargets,
//        dependencies: [TargetDependency],
//        settings: Settings
//    ) -> Target {
//        Target.target(
//            name: name,
//            destinations: .iOS,
//            product: .app,
//            bundleId: bundleId.lowercased(),
//            deploymentTargets: deploymentTargets,
//            infoPlist: .file(path: "AppOne/Info.plist"),
//            sources: [
//                "AppOne/**/*.swift"
//            ],
//            resources: [
//                "Demo1/Resources/**/*",
//            ],
//            scripts: [ ],
//            dependencies: dependencies,
//            settings: settings
//        )
//    }
//    
//    static func appTargets(
//        bundleId: String,
//        deploymentTargets: DeploymentTargets,
//        targetSettings: Settings,
//        externalDependencies: [TargetDependency] = Self.getExternalDependencies(),
//        localDependencies: [TargetDependency] = Self.getLocalDependencies()
//    ) -> [Target] {
//        [
//            Target.appTarget(
//                name: "AppOne",
//                bundleId: bundleId,
//                brandName: "AT.Soft",
//                appFolderName: "MainApp",
//                deploymentTargets: deploymentTargets,
//                dependencies: externalDependencies + localDependencies,
//                settings: targetSettings
//            ),
//            Target.testTarget(
//                name: "Demo1Tests",
//                appBundleId: "andrey.torlopov.ios.tests",
//                dependencies: [
//                    .target(name: "Demo1"),
//                ]
//            )
//        ]
//    }
//    
//    // MARK: - Project dependencies
//
//    static func getExternalDependencies() -> [TargetDependency] {
//        [ ]
//    }
//
//    static func getLocalDependencies() -> [TargetDependency] {
//        [ ]
//    }
//    
//}
