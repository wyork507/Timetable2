//
//  StringSeriesEditor.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/13.
//

import SwiftUI

struct StringSeriesEditor: View {
    private var title: String
    private var isIndex: Bool
    @Binding private var stringSeries: [String]
    @State private var newString: String = ""
    @State private var previousStringSeries: [String] = []
    @State private var showingDeleteAlert = false
    @State private var deleteIndexSet: IndexSet?
    
    init(title: String, stringSeries: Binding<[String]>, isIndex: Bool = true) {
        self.title = title
        self.isIndex = isIndex
        _stringSeries = stringSeries
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text(title)) {
                    if isIndex {
                        ForEach(0..<stringSeries.count, id: \.self) { index in
                            HStack {
                                Text("\(index + 1).")
                                    .frame(width: 40)
                                Text("\(stringSeries[index])")
                            }
                        }
                        .onDelete(perform: deleteString)
                    } else {
                        ForEach(stringSeries, id: \.self) { string in
                            Text(string)
                        }
                        .onDelete(perform: deleteString)
                    }
                }
                
                Section(header: Text("Add New \(title)")) {
                    HStack {
                        TextField("Enter a new one", text: $newString)
                        Button(action: addNewString) {
                            Text("Add")
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("\(title) Editor")
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Delete \(title)"),
                    message: Text("Are you sure you want to delete this \(title)?"),
                    primaryButton: .destructive(Text("Delete")) {
                        reallyDeleteString()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    func addNewString() {
        if !newString.isEmpty {
            stringSeries.append(newString)
            newString = ""
        }
    }
    
    func deleteString(at offsets: IndexSet) {
        previousStringSeries = stringSeries
        deleteIndexSet = offsets
        showingDeleteAlert = true
    }
    
    func reallyDeleteString() {
        if let offsets = deleteIndexSet {
            stringSeries.remove(atOffsets: offsets)
        }
    }
    
    func undoDelete() {
        stringSeries = previousStringSeries
    }
}

#Preview {
    StringSeriesEditor(title: "abc" ,stringSeries: .constant(["String 1", "String 2", "String 3"]))
}
