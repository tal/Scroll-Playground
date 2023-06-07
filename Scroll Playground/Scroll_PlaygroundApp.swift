//
//  Scroll_PlaygroundApp.swift
//  Scroll Playground
//
//  Created by Tal Atlas on 6/5/23.
//

import SwiftUI

@main
struct Scroll_PlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(items: [
                .init(id: 1, display: "one"),
                .init(id: 2, display: "two"),
                .init(id: 3, display: "three"),
            ]).safeAreaPadding()
        }
    }
}
