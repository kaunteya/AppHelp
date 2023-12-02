//
//  HelpModel.swift
//  MyGreatApp
//
//  Created by Kauntey Suryawanshi on 24/11/23.
//

import Foundation

class HelpModel: ObservableObject {
    var items: [HelpTopic]!
    @Published var selectedTopic: HelpTopic.ID?
    var scheme: String?
}
