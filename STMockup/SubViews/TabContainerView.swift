//
//  TabContainerView.swift
//  STMockup
//
//  Created by alfeng on 9/29/24.
//

import SwiftUI

struct TabContainerView: View {
    var body: some View {
        TabView {
            Group {
                ContentView()
                    .tabItem {
                        Label("Read Later", systemImage: "star")
                    }
                ContentView()
                    .tabItem {
                        Label("Articles", systemImage: "book")
                    }
                WordleView()
                    .tabItem {
                        Label("Games", systemImage: "gamecontroller")
                    }
            }
        }
    }
}

#Preview {
    TabContainerView()
}
