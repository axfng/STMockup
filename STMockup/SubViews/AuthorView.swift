//
//  AuthorView.swift
//  STMockup
//
//  Created by alfeng on 8/28/24.
//

import SwiftUI

struct AuthorView: View {
    let author: Author
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(author.id)
                        .font(.largeTitle)
                    Image(author.id)
                        .resizable()
                        .frame(width: 360, height: 360)
                    Text(author.bio)
                }
                .padding()
            }
            .navigationTitle("Author Bio")
        }
    }
}

#Preview {
    let authors: [String: Author] = Bundle.main.decode("mockup_author.json")
    return AuthorView(author: authors["Alex Feng"]!)
}
