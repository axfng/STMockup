//
//  ArticleView.swift
//  STMockup
//
//  Created by alfeng on 8/25/24.
//

import SwiftUI

struct ArticleView: View {
    struct TheAuthor {
        let bio: String
        let author: Author
    }
    
    let article: Article
    let crew: [TheAuthor]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    // title, image, body
                    Text(article.title)
                        .font(.title.bold())
                    Image(article.id)
                        .resizable()
                        .padding(.horizontal, 15)
                    HStack {
                        NavigationLink {
                            AuthorView()
                        } label : {
                            Image(article.id)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .clipShape(.circle)
                            VStack {
                                Text(article.title)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    HStack {
                        Text(article.formattedPublishDate)
                        Spacer()
                        Text(article.id)
                    }
                    .font(.caption2)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 18)
                    parseCustomTags(article.body)
                        .padding()
                }
            }
        }
    }
    
    init(article: Article, authors: [String: Author]) {
        self.article = article
        self.crew = article.crew.map {member in
            if let author = authors[member.name] {
                return TheAuthor(bio: author.bio, author: author)
            } else {
                fatalError("Missing member name")
            }
        }
    }
    
    
    // Parsing to bold highlighted text on body
    func parseCustomTags(_ text: String) -> Text {
        var resultText = Text("")

        // Split the text by "<b>" tag
        let components = text.components(separatedBy: "<b>")

        for component in components {
            // Split by "</b>" tag if exists
            if component.contains("</b>") {
                let parts = component.components(separatedBy: "</b>")
                resultText = resultText + Text(parts[0]).bold() + Text(parts[1])
            } else {
                resultText = resultText + Text(component)
            }
        }

        return resultText
    }
}

#Preview {
    let articles: [Article] = Bundle.main.decode("mockup_article.json")
    let authors: [String: Author] = Bundle.main.decode("mockup_author.json")
    
    return ArticleView(article: articles[0], authors: authors)
}
