#!/usr/bin/swift sh
import Stencil // https://github.com/stencilproject/Stencil

struct App {
    let name: String
    let bundleIdentifier: String
}

struct Framework {
    let name: String
    let bundleIdentifier: String
}

let context: [String: Any] = [
  "app": App(name: "Bitrise-iOS", bundleIdentifier: "com.bivre.bitrise-client"),
  "frameworks": [
    Framework(name: "Shared", bundleIdentifier: "com.bivre.bitrise-client.shared"),
    Framework(name: "Login", bundleIdentifier: "com.bivre.bitrise-client.login"),
    Framework(name: "Bitrise", bundleIdentifier: "com.bivre.bitrise-client.bitrise"),
    Framework(name: "Settings", bundleIdentifier: "com.bivre.bitrise-client.settings"),
  ]
]

let environment = Environment(loader: FileSystemLoader(paths: ["scripts/templates/"]))
let rendered = try environment.renderTemplate(name: "project.stencil", context: context)

print(rendered)