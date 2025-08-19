//
//  TimetableDetailView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/19.
//

import SwiftUI
import SwiftData

struct TimetableDetailView: View {
    @Environment(\.modelContext) private var context
    @Binding var timetable: Timetables
    
    
    var body: some View {
        NavigationStack {
            Text("HI")
        }.navigationTitle("Timetable Detail")
    }
}

/*
#Preview {
    TimetableDetailView()
}
*/
