//
//  File.swift
//  
//
//  Created by Kauntey Suryawanshi on 03/12/23.
//

import Foundation
import Markdown

extension Document {
    var title: String? {
        (child(at: 0) as? Heading)?.plainText
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
//        var documentMarkup = Document(parsing: markdownContent)

    }
}
