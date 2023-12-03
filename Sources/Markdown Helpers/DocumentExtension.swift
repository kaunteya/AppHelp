//
//  File.swift
//  
//
//  Created by Kauntey Suryawanshi on 03/12/23.
//

import Foundation
import Markdown

extension Document {
    struct TopicInfo {
        let title: String
        let keywords: [String]
    }

    var firstHeading: String? {
        (child(at: 0) as? Heading)?.plainText
    }

    var topicInfo: TopicInfo? {
        var title: String?
        var keywords = [String]()

        for i in (0..<childCount) {
            if let b = child(at: i) as? HTMLBlock, let (k,v) = b.keyValue {
                if k.lowercased() == "title" {
                    title = v
                } else if k.lowercased() == "keywords" {
                    keywords = v.components(separatedBy: ",").map { String($0) }
                }
            } else {
                break
            }
        }
        if let title {
            return TopicInfo(title: title, keywords: keywords)
        }
        return nil
    }

    mutating func applyingLocalImageRewrite() {
        var imageFixedMarkup = LocalImageRewriter()
        self = imageFixedMarkup.visit(self) as! Document
    }

    init(fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "md"),
              let markdownContent = try? String(contentsOfFile: path) else {
            fatalError("Failed to open markdown file")
        }
        self.init(parsing: markdownContent)
    }
}

fileprivate extension HTMLBlock {
    var text: String {
        var text = self.rawHTML.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.hasPrefix("<!--") {
            text = String(text.dropFirst(4))
        }
        if text.hasSuffix("-->") {
            text = String(text.dropLast(4))
        }
        return text.trimmingCharacters(in: .whitespaces)
    }

    var keyValue: (String, String)? {
        let components = text.components(separatedBy: ":")
        if components.count == 2 {
            return (String(components[0].trimmingCharacters(in: .whitespaces)), String(components[1]).trimmingCharacters(in: .whitespaces))
        }
        return nil
    }
}
