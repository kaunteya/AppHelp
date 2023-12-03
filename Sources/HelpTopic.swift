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

        var documentMarkup = Document(fileName: markdownFileName)
        self.title = documentMarkup.title!

        documentMarkup.applyingLocalImageRewrite()
        @HTMLWrapper var htmlText = HTMLFormatter.format(documentMarkup)
        value = .web(html: htmlText)
    }
}

struct HelpGroup {
    var name: String
    @HelpBuilder var topics: () -> [HelpTopic]
}

protocol HelpTopicConvertible {
    func asHelpTopic() -> [HelpTopic]
}

extension HelpTopic: HelpTopicConvertible {
    func asHelpTopic() -> [HelpTopic] { [self] }
}

extension HelpGroup: HelpTopicConvertible {
    func asHelpTopic() -> [HelpTopic] {
        [HelpTopic(groupName: name, topics: topics())]
    }
}
