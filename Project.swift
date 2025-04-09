import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Constants
let marketingVersion = "1.1.0"
let currentProjectVersion = "1"
let bundleId = "torlopov.app.one"
let minimalVersioniOS = "18.0"
let swiftVersion = "6"

// MARK: -

let resourceSynthesizers: [ResourceSynthesizer] = [
    .assets(),
    .strings(),
    .fonts(),
    .coreData(),
    .files(extensions: ["json", "yaml"]) // Добавьте свои расширения
]


let project = Project(
    name: "AppOne",
    options: .options(
        automaticSchemesOptions: .enabled(
            targetSchemesGrouping: .byNameSuffix(build: ["Dev", "Prod"], test: ["Tests"], run: [])),
        disableSynthesizedResourceAccessors: true
    ),
    settings: Settings.settings(
        base: SettingsDictionary()
            .marketingVersion(marketingVersion)
            .currentProjectVersion(currentProjectVersion)
            .swiftVersion(swiftVersion)
            .otherLinkerFlags(["-ObjC"])
            .debugInformationFormat(.dwarfWithDsym)
            .otherSwiftFlags(["-D IS_PRODUCTION", "-D TUIST"]),
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ]
    ),
    targets: [
        .target(
            name: "AppOneDev",
            destinations: .iOS,
            product: .app,
            bundleId: bundleId.lowercased(),
            deploymentTargets: .iOS(minimalVersioniOS),
            infoPlist: .file(path: "AppOne/Apps/Dev/Info.plist"),
            sources: ["AppOne/Sources/**"],
            resources: ["AppOne/Apps/Dev/**"],
            dependencies: [],
            settings: Settings.settings(
                base: [
                    "CODE_SIGN_STYLE": "Manual",
                    "DEVELOPMENT_TEAM": "79798GRSHW",
                    "ENABLE_USER_SCRIPT_SANDBOXING": "NO",
                    "SDKROOT": "iphoneos",
                    "TARGETED_DEVICE_FAMILY": "1",
                    "OTHER_SWIFT_FLAGS[config=Debug]": "$(inherited) -D DEBUG -D XCLOUDDEMO",
                    "OTHER_SWIFT_FLAGS[config=Release]": "$(inherited) -D XCLOUDDEMO",
                    "SWIFT_VERSION": "6.0",
                    "PROVISIONING_PROFILE_SPECIFIER[config=Debug]": "xcloud-dev",
                    "PROVISIONING_PROFILE_SPECIFIER[config=Release]": "xcloud-dev"
                ]
            )
        ),
        .target(
            name: "AppOne",
            destinations: .iOS,
            product: .app,
            bundleId: bundleId.lowercased(),
            deploymentTargets: .iOS(minimalVersioniOS),
            infoPlist: .file(path: "AppOne/Apps/Prod/Info.plist"),
            sources: ["AppOne/Sources/**",
                      "AppOne/Apps/Prod/**"],
            resources: ["AppOne/Resources/**"],
            dependencies: [],
            settings: Settings.settings(
                base: [
                    "CODE_SIGN_STYLE": "Manual",
                    "DEVELOPMENT_TEAM": "79798GRSHW",
                    "ENABLE_USER_SCRIPT_SANDBOXING": "NO",
                    "SDKROOT": "iphoneos",
                    "TARGETED_DEVICE_FAMILY": "1",
                    "OTHER_SWIFT_FLAGS[config=Debug]": "$(inherited) -D DEBUG -D XCLOUDDEMO",
                    "OTHER_SWIFT_FLAGS[config=Release]": "$(inherited) -D XCLOUDDEMO",
                    "SWIFT_VERSION": "6.0",
                    "PROVISIONING_PROFILE_SPECIFIER[config=Debug]": "xcloud-prod",
                    "PROVISIONING_PROFILE_SPECIFIER[config=Release]": "xcloud-prod"
                ])
        ),
        .testTarget(
            name: "AppOneDevTests",
            appBundleId: bundleId + ".devTests",
            dependencies: [.target(name: "AppOneDev")]
        )
        
    ],
    schemes: [
        .scheme(
               name: "AppOneDev",
               shared: true,
               buildAction: .buildAction(targets: ["AppOneDev"]),
               testAction: .targets(["AppOneDevTests"])
           ),
           .scheme(
               name: "AppOne",
               shared: true,
               buildAction: .buildAction(targets: ["AppOne"])
           )
    ]
    ,resourceSynthesizers: resourceSynthesizers
)
