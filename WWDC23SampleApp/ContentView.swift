//
//  ContentView.swift
//  WWDC23SampleApp
//
//  Created by 藤井陽介 on 2023/06/07.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \.timestamp, order: .reverse) private var items: [Item]
    @State private var isAlertPresented: Bool = false
    @State private var name: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack {
                            KeyframeAnimator(
                                initialValue: ImageAnimationValues(), repeating: true
                            ) { values in
                                    Image(systemName: "cat.circle.fill")
                                        .resizable()
                                        .frame(width: 200, height: 200)
                                        .rotationEffect(values.rotation)
                                } keyframes: { _ in
                                    KeyframeTrack(\.rotation) {
                                        SpringKeyframe(Angle(degrees: -20), spring: .bouncy(duration: 0.1))
                                        SpringKeyframe(Angle(degrees: 20), spring: .bouncy(duration: 0.1))
                                    }
                                }
                            Text("Created at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        }
                        .navigationTitle(Text(item.name))
                    } label: {
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .shortened, locale: Locale(identifier: "ja_JP")))
                                .font(.footnote)
                                .fontDesign(.monospaced)
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
        .alert("タイトルを入力してください", isPresented: $isAlertPresented) {
            TextField("タイトルを入力", text: $name)
            Button("OK", action: submit)
        }
    }

    private func addItem() {
        isAlertPresented = true
    }
    
    private func submit() {
        withAnimation {
            let newItem = Item(timestamp: Date(), name: name)
            modelContext.insert(newItem)
        }
        name = ""
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
        .modelContainer(for: Item.self, inMemory: true)
}
