//
//  File.swift
//  
//
//  Created by Kauntey Suryawanshi on 03/12/23.
//

import Foundation

@resultBuilder
public struct HelpBuilder {

//    static func buildBlock() -> [HelpTopic] { [] }

//    static func buildBlock(_ components: HelpTopic) -> [HelpTopic] {
//        [components]
//    }

    public static func buildBlock(_ components: HelpTopicConvertible...) -> [HelpTopic] {
        components.flatMap { $0.asHelpTopic() }
    }

//    static func buildArray(_ components: [HelpTopic]) -> [HelpTopic] {
//        components
//    }

//    static func buildPartialBlock(first: [HelpTopic]) -> [HelpTopic] {
//        first
//    }
//
//    static func buildPartialBlock(accumulated: [HelpTopic], next: [HelpTopic]) -> [HelpTopic] {
//        accumulated
//    }

//    public static func buildExpression(_ expr: HelpTopicConvertible?) -> [HelpTopic] {
//        expr.map { [$0] } ?? []
//    }
//
//    public static func buildBlock(_ block: [HelpTopicConvertible]...) -> [HelpTopic] {
//        block.flatMap { $0 }
//    }

//    public static func buildOptional(_ item: [HelpTopic]?) -> [HelpTopic] {
//        item ?? []
//    }

//    public static func buildEither(first: [HelpTopic]?) -> [HelpTopic] {
//        first ?? []
//    }
//    public static func buildEither(second: [HelpTopic]?) -> [HelpTopic] {
//        second ?? []
//    }

//    public static func buildArray(_ components: [[HelpTopic]]) -> [HelpTopic] {
//        components.flatMap { $0 }
//    }

//    public static func buildExpression(_ expr: [HelpTopic]?) -> [HelpTopic] {
//        expr ?? []
//    }
}
