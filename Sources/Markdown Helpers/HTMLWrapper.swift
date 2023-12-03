//
//  File.swift
//  
//
//  Created by Kauntey Suryawanshi on 03/12/23.
//

import Foundation

@propertyWrapper
struct HTMLWrapper {
    var wrappedValue: String

    init(wrappedValue: String) {
        self.wrappedValue = Self.apply(baseHTML: wrappedValue)
    }

    private static func apply(baseHTML: String) -> String {
        let cssPath = Bundle.module.path(forResource: "style", ofType: "css")!
        let css = try! String(contentsOfFile: cssPath).trimmingCharacters(in: .whitespacesAndNewlines)

        return """
<!DOCTYPE html>
<html>
    <head><style>\(css)</style></head>
    <body>\(baseHTML)</body>
</html>
"""
    }
}
