//
//  ContentView.swift
//  Logger
//
//  Created by Zachary Cohen on 7/26/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [LogItem]

    @State private var showAlert = false
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button("Show Alert") {
                        showAlert = true
                    }
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
                }
            }
        } detail: {
            Text("Select an item")
        }.alert(isPresented: $showAlert, content: { self.alertFunc() })
    }

    func alertFunc() -> Alert {
        Alert(
            title: Text("test"),
            message: Text("this is the message"),
            dismissButton: .default(Text("Dismiss"))
        )
    }
    
    private func addItem() {
        withAnimation {
            let newItem = LogItem(timestamp: Date(), note: "Hello World")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: LogItem.self, inMemory: true)
}
