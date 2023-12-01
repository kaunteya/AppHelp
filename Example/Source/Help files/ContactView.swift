//
//  ContactView.swift
//  MyGreatApp
//
//  Created by Kauntey Suryawanshi on 30/11/23.
//

import SwiftUI

struct ContactView: View {
    var body: some View {
        VStack {
            Text("Contact us")
                .font(.title)
            Text("For queries, suggestions and feedback,\nplease drop an email at k.suryawanshi@gmail.com")
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ContactView()
}
