#!/usr/bin/swift sh
import Stencil // https://github.com/stencilproject/Stencil

struct Article {
  let title: String
  let author: String
}

let context = [
  "articles": [
    Article(title: "Migrating from OCUnit to XCTest", author: "Kyle Fuller"),
    Article(title: "Memory Management with ARC", author: "Kyle Fuller"),
  ]
]

let environment = Environment(loader: FileSystemLoader(paths: ["scripts/templates/"]))
let rendered = try environment.renderTemplate(name: "sample.stencil", context: context)

print(rendered)