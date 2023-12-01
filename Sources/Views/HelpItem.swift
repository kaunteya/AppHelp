//
//  File.swift
//  
//
//  Created by Kauntey Suryawanshi on 29/11/23.
//

import Foundation
import SwiftUI
import Markdown

public struct HelpItem: Identifiable {
    enum ViewType {
        case web(html: String)
        case view(AnyView)
    }
    public typealias ID = String
    
    public var id: ID
    var title: String
    let viewType: ViewType

    @ViewBuilder
    var view: some View {
        switch viewType {
        case .web(let html):
            DetailWebView(htmlText: html)
        case .view(let v):
            v
        }
    }
    
    public init(id: String, title: String, view: AnyView) {
        self.id = id
        self.title = title
        self.viewType = .view(view)
    }

    public init(markdownFileName: String) throws {
        self.id = markdownFileName

        let markdownContent = try String(contentsOfFile: Bundle.main.path(forResource: markdownFileName, ofType: "md")!)
        let documentMarkup = Document(parsing: markdownContent)
        self.title = documentMarkup.title!

        var imageFixedMarkup = LocalImageRewriter()
        guard let updatedMarkup = imageFixedMarkup.visit(documentMarkup) else {
            throw "Image url converstion failed"
        }

        let htmlText = HelpItem.wrapInHtml(content: HTMLFormatter.format(updatedMarkup))
        viewType = .web(html: htmlText)
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

fileprivate extension Document {
    var title: String? {
        (child(at: 0) as? Heading)?.plainText
    }
}


