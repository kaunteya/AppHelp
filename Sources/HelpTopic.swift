//
//  File.swift
//  
//
//  Created by Kauntey Suryawanshi on 29/11/23.
//

import Foundation
import SwiftUI
import Markdown

public struct HelpTopic: Identifiable {
    enum Value {
        case web(html: String)
        case view(AnyView)
        case group([HelpTopic])
    }
    public typealias ID = String
    
    public var id: ID
    var title: String
    let value: Value

    @ViewBuilder
    var view: some View {
        switch value {
        case .web(let html):
            DetailWebView(htmlText: html)
        case .view(let v):
            v
        case .group: EmptyView()
        }
    }
    
    public init(id: String, title: String, view: AnyView) {
        self.id = id
        self.title = title
        self.value = .view(view)
    }

    public init(groupName: String, topics: [HelpTopic]) {
        self.id = groupName
        self.title = groupName
        self.value = .group(topics)
    }

    public init(markdownFileName: String) {
        self.id = markdownFileName

        guard let path = Bundle.main.path(forResource: markdownFileName, ofType: "md"),
              let markdownContent = try? String(contentsOfFile: path) else {
            fatalError("Failed to open markdown file")
        }

        self.title = Document(parsing: markdownContent).title!

        print("Setting title \(self.title)")
        var imageFixedMarkup = LocalImageRewriter()
        guard let updatedMarkup = imageFixedMarkup.visit(documentMarkup) else {
            fatalError("Image url converstion failed")
        }

        let htmlText = HelpTopic.wrapInHtml(content: HTMLFormatter.format(updatedMarkup))
        value = .web(html: htmlText)
    }

    private static func wrapInHtml(content: String) -> String {
        let cssPath = Bundle.module.path(forResource: "style", ofType: "css")!
        let css = try! String(contentsOfFile: cssPath).trimmingCharacters(in: .whitespacesAndNewlines)

        return """
<!DOCTYPE html>
<html>
    <head><style>\(css)</style></head>
    <body>\(content)</body>
</html>
"""
    }
}
