//
//  UnderConstruction.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/15.
//

import SwiftUI

struct UnderConstruction: View {
    var body: some View {
        NavigationStack {
            Image(systemName:"hammer")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Under Developing")
                .font(.title)
        }
    }
}

#Preview {
    UnderConstruction()
}
