#!/usr/bin/swift sh
import XcodeGenKit // https://github.com/yonaskolb/XcodeGen
import ProjectSpec
import Stencil // https://github.com/stencilproject/Stencil

let project = Project(
  name: "Bitrise-iOS",
  targets: [
    Target(
      name: "Bitrise-iOS",
      type: .application,
      platform: .iOS,
      settings: Settings(dictionary: [
        "PRODUCT_BUNDLE_IDENTIFIER": "com.bivre.bitrise-client"
      ]),
      sources: [
        TargetSource(path: "Bitrise-iOS"),
      ],
      dependencies: [
        Dependency(type: .target, reference: "Shared"),
        Dependency(type: .target, reference: "Login"),
        Dependency(type: .target, reference: "Bitrise"),
        Dependency(type: .target, reference: "Settings"),
        Dependency(type: .target, reference: "BitriseAPI"),
        Dependency(type: .carthage(findFrameworks: nil), reference: "APIKit"),
      ]
    ),
    Target(
      name: "Shared",
      type: .framework,
      platform: .iOS,
      settings: Settings(dictionary: [
        "PRODUCT_BUNDLE_IDENTIFIER": "com.bivre.bitrise-client.shared"
      ]),
      sources: [
        TargetSource(path: "Shared"),
      ],
      dependencies: [
      ]
    ),
    Target(
      name: "SharedTests",
      type: .unitTestBundle,
      platform: .iOS,
      sources: [
        TargetSource(path: "SharedTests"),
      ],
      dependencies: [
        Dependency(type: .target, reference: "Bitrise-iOS"),
        Dependency(type: .target, reference: "Shared"),
      ]
    ),
    Target(
      name: "Login",
      type: .framework,
      platform: .iOS,
      settings: Settings(dictionary: [
        "PRODUCT_BUNDLE_IDENTIFIER": "com.bivre.bitrise-client.login"
      ]),
      sources: [
        TargetSource(path: "Login"),
      ],
      dependencies: [
      ]
    ),
    Target(
      name: "LoginTests",
      type: .unitTestBundle,
      platform: .iOS,
      sources: [
        TargetSource(path: "LoginTests"),
      ],
      dependencies: [
        Dependency(type: .target, reference: "Bitrise-iOS"),
        Dependency(type: .target, reference: "Login"),
      ]
    ),
    Target(
      name: "Bitrise",
      type: .framework,
      platform: .iOS,
      settings: Settings(dictionary: [
        "PRODUCT_BUNDLE_IDENTIFIER": "com.bivre.bitrise-client.bitrise"
      ]),
      sources: [
        TargetSource(path: "Bitrise"),
      ],
      dependencies: [
      ]
    ),
    Target(
      name: "BitriseTests",
      type: .unitTestBundle,
      platform: .iOS,
      sources: [
        TargetSource(path: "BitriseTests"),
      ],
      dependencies: [
        Dependency(type: .target, reference: "Bitrise-iOS"),
        Dependency(type: .target, reference: "Bitrise"),
      ]
    ),
    Target(
      name: "Settings",
      type: .framework,
      platform: .iOS,
      settings: Settings(dictionary: [
        "PRODUCT_BUNDLE_IDENTIFIER": "com.bivre.bitrise-client.settings"
      ]),
      sources: [
        TargetSource(path: "Settings"),
      ],
      dependencies: [
      ]
    ),
    Target(
      name: "SettingsTests",
      type: .unitTestBundle,
      platform: .iOS,
      sources: [
        TargetSource(path: "SettingsTests"),
      ],
      dependencies: [
        Dependency(type: .target, reference: "Bitrise-iOS"),
        Dependency(type: .target, reference: "Settings"),
      ]
    ),
    Target(
      name: "BitriseAPI",
      type: .framework,
      platform: .iOS,
      settings: Settings(dictionary: [
        "PRODUCT_BUNDLE_IDENTIFIER": "com.bivre.bitrise-client.bitrise-api"
      ]),
      sources: [
        TargetSource(path: "BitriseAPI"),
      ],
      dependencies: [
        Dependency(type: .carthage(findFrameworks: nil), reference: "APIKit"),
      ]
    )
  ],
  settings: Settings(dictionary: [
    "DEVELOPMENT_TEAM": "PS98BD6732",
    "CODE_SIGN_STYLE": "Automatic"
  ]),
  options: SpecOptions(
    minimumXcodeGenVersion: .init("2.5.0"),
    carthageExecutablePath: "mint run Carthage/Carthage carthage",
    bundleIdPrefix: "com.bivre",
    deploymentTarget: .init(iOS: "11.0")
  ))

// Generate
let generator = ProjectGenerator(project: project)
let fileWriter = FileWriter(project: project)
try! fileWriter.writePlists()
let xcodeproj = try! generator.generateXcodeProject()
try fileWriter.writeXcodeProject(xcodeproj, to: "Bitrise-iOS.xcodeproj")
