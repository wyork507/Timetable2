//
//  StringSeriesEditor2.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/15.
//

import SwiftUI

struct StringSeriesEditor2: View {
    private var title: String
    @Binding private var stringSeries: [String]
    @State private var editIndex: Int?
    @State private var editText: String = ""
    
    init(title: String, stringSeries: Binding<[String]>) {
        self.title = title
        _stringSeries = stringSeries
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<stringSeries.count, id: \.self) { index in
                    if index == editIndex {
                        HStack {
                            Text("\(index + 1).")
                                .frame(width: 40)
                            TextField("New value", text: $editText)
                            Button(action: { saveEdit() }) {
                                Text("Done")
                                    .frame(width: 60)
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        HStack {
                            Text("\(index + 1).")
                                .frame(width: 40)
                            Text("\(stringSeries[index])")
                            Spacer()
                            Button(action: { startEditing(index: index) }) {
                                Text("Edit")
                                    .frame(width: 60)
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("\(title) Editor")
        }
    }
    
    func startEditing(index: Int) {
        editIndex = index
        editText = stringSeries[index]
    }
    
    func saveEdit() {
        if let index = editIndex, !editText.isEmpty {
            stringSeries[index] = editText
            editIndex = nil
        }
    }
}


#Preview {
    StringSeriesEditor2(title: "abc" ,stringSeries: .constant(["String 1", "String 2", "String 3"]))
}
