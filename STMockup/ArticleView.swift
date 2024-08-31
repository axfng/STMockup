//
//  ArticleView.swift
//  STMockup
//
//  Created by alfeng on 8/25/24.
//

import SwiftUI

struct ArticleView: View {
    struct contributor {
        let bio: String
        let author: Author
    }
    
    let article: Article
    let contributors: [contributor]
    
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
                        Text(article.formattedPublishDate)
                        Spacer()
                        Text(article.id)
                    }
                    .font(.caption2)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 18)
                    
                    parseCustomTags(article.body)
                        .padding(.horizontal, 18)
                }
                HStack {
                    ForEach(contributors, id: \.bio) { contributor in
                        NavigationLink {
                            AuthorView(author: contributor.author)
                        } label: {
                            Image(contributor.author.id)
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(.circle)
                            VStack {
                                Text(contributor.bio)
                                    .sTCaption()
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    init(article: Article, authors: [String: Author]) {
        self.article = article
        self.contributors = article.contributors.map {member in
            if let author = authors[member.name] {
                return contributor(bio: author.bio, author: author)
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
