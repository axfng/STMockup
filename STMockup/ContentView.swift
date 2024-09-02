//
//  ContentView.swift
//  STMockup
//
//  Created by alfeng on 8/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showGridView = false
    var changeView: String {
        if showGridView {
            return "Show List"
        } else {
            return "Show Grid"
        }
    }
    
    let authors: [String: Author] = Bundle.main.decode("mockup_author.json")
    let articles: [Article] = Bundle.main.decode("mockup_article.json")
    let links: [(AnyView, String)] = [
        (AnyView(ScienceNewsView()), "Science News |"),
        (AnyView(ScienceMythsView()), "Science Myths |"),
        (AnyView(ScienceSparknotesView()), "Science Sparknotes |"),
        (AnyView(AboutUsView()), "About Us |"),
        (AnyView(GetInvolvedView()), "Get Involved |"),
        (AnyView(ContactUsView()), "Contact Us")
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            // sticky header
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(links, id: \.1) { view, label in
                        NavigationLink(destination: view) {
                            Text(label)
                        }
                    }
                }
                .foregroundStyle(.black)
                .padding(.horizontal, 18)
                .padding(.vertical, 5)
            }
            
            ZStack(alignment: .top) {
                ScrollView {
                    if showGridView {
                        LazyVGrid(columns: columns){
                            ForEach(articles) { article in
                                NavigationLink {
                                    ArticleView(article: article, authors: authors)
                                } label: {
                                    VStack {
                                        Image(article.id)
                                            .resizable()
                                        
                                    }
                                }
                                
                            }
                        }
                    } else {
                        ForEach(articles) { article in
                            NavigationLink {
                                ArticleView(article: article, authors: authors)
                            } label: {
                                VStack {
                                    Text(article.title)
                                        .foregroundStyle(.black)
                                        .font(.title2.bold())
                                    
                                    VStack {
                                        Text(article.preview)
                                            .sTCaption()
                                        Image(article.id)
                                            .resizable()
                                        
                                        HStack {
                                            Text(article.formattedPublishDate)
                                            Spacer()
                                            Text(article.id)
                                        }
                                        .font(.caption2)
                                        .foregroundStyle(.black)
                                    }
                                    .padding(.horizontal, 10)
                                }
                                .padding(.horizontal, 10)
                            }
                        }
                    }
                }
                // toggle between grid and list view
                .navigationTitle("Science, Translated")
                .toolbar {
                    Button(changeView) {
                        showGridView.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
