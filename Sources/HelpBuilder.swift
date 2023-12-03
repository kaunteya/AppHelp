//
//  File.swift
//  
//
//  Created by Kauntey Suryawanshi on 03/12/23.
//

import Foundation

@resultBuilder
public struct HelpBuilder {
    public static func buildBlock(_ components: HelpTopicConvertible...) -> [HelpTopic] {
        components.flatMap { $0.asHelpTopic() }
    }
}
