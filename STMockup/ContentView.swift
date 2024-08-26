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
    
    let articles: [Article] = Bundle.main.decode("mockup_article.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        NavigationLink {
                            ScienceNewsView()
                        } label: {
                            Text("Science News |")
                        }
                        NavigationLink {
                            ScienceMythsView()
                        } label: {
                            Text("Science Myths |")
                        }
                        NavigationLink {
                            ScienceSparknotesView()
                        } label: {
                            Text("Science Sparknotes |")
                        }
                        NavigationLink {
                            AboutUsView()
                        } label: {
                            Text("About Us |")
                        }
                        NavigationLink {
                            GetInvolvedView()
                        } label: {
                            Text("Get Involved |")
                        }
                        NavigationLink {
                            ContactUsView()
                        } label: {
                            Text("Contact Us |")
                        }
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 5)
                }
                
                if showGridView {
                    LazyVGrid(columns: columns){
                        ForEach(articles) { article in
                            NavigationLink {
                                ArticleView(article: article)
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
                            ArticleView(article: article)
                        } label: {
                            VStack {
                                Text(article.title)
                                    .foregroundStyle(.black)
                                    .font(.title2.bold())
                                VStack {
                                    Text(article.preview)
                                        .foregroundStyle(.black)
                                        .font(.caption2)
                                        .multilineTextAlignment(.leading)
                                    
                                    
                                    Image(article.id)
                                        .resizable()
                                    
                                    HStack {
                                        Text(article.formattedPublishDate)
                                        Spacer()
                                        Text(article.author)
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
            .toolbar {
                Button(changeView) {
                    showGridView.toggle()
                }
            }
            .navigationTitle("Science, Translated")
        }
    }
}

#Preview {
    ContentView()
}
