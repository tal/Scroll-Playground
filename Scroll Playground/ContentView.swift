//
//  ContentView.swift
//  Scroll Playground
//
//  Created by Tal Atlas on 6/5/23.
//

import SwiftUI

let wordFormatter = NumberFormatter()

let colors: [Color] = [
    .red,
    .orange,
    .blue,
    .black,
    .cyan,
    .purple,
    .pink,
    .indigo,
    .green,
]

struct Item: Identifiable {
    var id: Int
    var display: String
    var color: Color {
        colors[(id+1000) % colors.count]
    }
    
    func buildNext() -> Item {
        wordFormatter.numberStyle = .spellOut
        let id = self.id + 1
        let display = wordFormatter.string(for: id)
        
        print("Building \(id) \(String(describing: display))")
        
        return Item(id: id, display: display ?? "\(id)")
    }
    
    func buildPrev() -> Item {
        wordFormatter.numberStyle = .spellOut
        let id = self.id - 1
        let display = wordFormatter.string(for: id)
        
        print("Building \(id) \(String(describing: display))")
        
        return Item(id: id, display: display ?? "\(id)")
    }
}

struct ItemView: View {
    let item: Item

    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 12)
                .foregroundColor(item.color)
                .frame(minHeight: 200)
            Spacer()
            Text(item.display)
                .padding()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.blue)
        )
        .padding()
        .containerRelativeFrame(.horizontal, alignment: .bottom)
    }
}

struct BasicScrollTargetBehavior: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        print("target \(String(describing: target.rect.minY))")
        print("height \(context.containerSize.height)")
        print("")
    }
}

struct ContentView: View {
    @State
    var items: [Item]
    
    @State
    var scrolledID: Item.ID? = 2
    
    func PrevView() -> some View {
        Button {
            if let first = items.first {
                items.insert(first.buildPrev(), at: 0)
            }
        } label: {
            HStack {
                Spacer()
                Text("Previous")
                Spacer()
            }
                .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.green)
            )
        }.padding()
    }
    
    func NextView() -> some View {
        Button {
            if let last = items.last {
                items.append(last.buildNext())
            }
        } label: {
            HStack {
                Spacer()
                Text("Next")
                Spacer()
            }
                .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.green)
            )
        }.padding()
    }
    
    var body: some View {
        ZStack {
            ScrollView() {
                LazyVStack {
                    PrevView()
                    ForEach(items) { item in
                        ItemView(item: item)
                            .scrollTarget(isEnabled: true)
                    }
                    NextView()
                    Spacer()
                        .frame(height: 100)
                }.scrollTargetLayout()
            }
            .scrollPosition(id: $scrolledID)
            .scrollTargetBehavior(BasicScrollTargetBehavior())
            if let scrolledID {
                Text("ScrollID: \(scrolledID)")
            } else {
                Text("ScrollID: nil")
            }
        }
    }
}

#Preview {
    ContentView(
        items: [
            .init(id: 1, display: "one"),
            .init(id: 2, display: "two"),
            .init(id: 3, display: "three"),
        ]
    )
}
