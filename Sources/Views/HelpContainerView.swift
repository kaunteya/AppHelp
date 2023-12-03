//
//  HelpView.swift
//  MyGreatApp
//
//  Created by Kauntey Suryawanshi on 23/11/23.
//

import SwiftUI

struct HelpContainerView: View {

    @State var selectedTopic: HelpTopic.ID?
    let topics: [HelpTopic]
    var body: some View {
        NavigationView {
            List(selection: $selectedTopic) {
                ForEach(topics) { topic in
                    NavigationLink(topic.title) {
                        topic.view
                    }
                }
            }
            .listStyle(.sidebar)
            .frame(minWidth: 200)
        }
        .frame(minWidth: 700, minHeight: 500)
    }
}
