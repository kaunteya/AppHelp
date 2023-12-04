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
        var documentMarkup = Document(fileName: markdownFileName)
        guard let topicInfo = documentMarkup.topicInfo else {
            fatalError("Please set appropriate headers in markdown file")
        }
        self.id = topicInfo.id
        self.title = topicInfo.title ?? documentMarkup.firstHeading ?? "TITLE UNAVAILABLE"
        documentMarkup.applyingLocalImageRewrite()
        @HTMLWrapper var htmlText = HTMLFormatter.format(documentMarkup)
        value = .web(html: htmlText)
    }
}

public struct HelpGroup {
    var name: String
    var topics: [HelpTopic]

    public init(_ name: String, @HelpBuilder topics: () -> [HelpTopic]) {
        self.name = name
        self.topics = topics()
    }
}

public protocol HelpTopicConvertible {
    func asHelpTopic() -> [HelpTopic]
}

extension HelpTopic: HelpTopicConvertible {
    public func asHelpTopic() -> [HelpTopic] { [self] }
}

extension HelpGroup: HelpTopicConvertible {
    public func asHelpTopic() -> [HelpTopic] {
        [HelpTopic(groupName: name, topics: topics)]
    }
}
