//
//  SchoolListView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/18.
//

import SwiftUI
import SwiftData

struct SchoolListView: View {
    @Query(sort: [SortDescriptor(\School.name)], animation: .snappy)
    private var schools: [School]
    @State private var studySchool = UserPreference.General().studySchool
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(schools) { school in
                    NavigationLink {
                        UnderConstruction()
                        //SchoolDetailView(school)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(school.name)
                            Text(school.campuses.joined(separator: ", "))
                        }
                    }
                    .frame(height: 38)
                }
            }
        }
        .navigationTitle("Schools")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: UnderConstruction() ) {
                    Label("Add School", systemImage: "plus")
                }
            }
        }
    }
}


#Preview {
    SchoolListView()
        .modelContainer(for: School.self, inMemory: true)
}
