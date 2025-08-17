//
//  AboutThisAppView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/17.
//

import SwiftUI

struct AboutThisAppView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(content: {
                    ContentUnavailableView("Timetable App", systemImage: "square.grid.3x3.topleft.filled",
                                           description: Text("Version 0.0.1"))
                }, footer: {
                    Text("A app designed to help you manage school time. You can check your school timetable schedule, and could remind you of the homework that you need to do.")
                })
                Section("Developer Infomation") {
                    LabeledContent("Version", value: "0.0.1")
                    LabeledContent("Publish Date", value: "2025/xx/xx")
                }
                Section("Contact Infomation") {
                    LabeledContent("Author", value: "York Wang")
                    LabeledContent("E-mail", value: "wyork507@gmail.com")
                }
            }.listStyle(.insetGrouped)
                .frame(height: .infinity)
        }.navigationTitle(Text("About This App"))
    }
}

#Preview {
    AboutThisAppView()
}
