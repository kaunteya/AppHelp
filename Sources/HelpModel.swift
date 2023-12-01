//
//  HelpModel.swift
//  MyGreatApp
//
//  Created by Kauntey Suryawanshi on 24/11/23.
//

import Foundation

class HelpModel: ObservableObject {
    var items: [HelpItem]!
    @Published var selectedTopic: HelpItem.ID?
    var scheme: String?
}
