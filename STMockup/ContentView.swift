//
//  ContentView.swift
//  STMockup
//
//  Created by alfeng on 8/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showGridView = true
    var changeView: String {
        if showGridView {
            return "Show List"
        } else {
            return "Show Grid"
        }
    }
    
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // toggle between grid and list view
                if showGridView {
                    LazyVGrid(columns: columns){
                        HStack {
                            
                        }
//                        ForEach {
//
//                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
