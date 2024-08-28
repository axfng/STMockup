//
//  ArticleView.swift
//  STMockup
//
//  Created by alfeng on 8/25/24.
//

import SwiftUI

struct Content: Codable {
    let content: String
}

struct ArticleView: View {
    let article: Article
    let authors: [Author] = Bundle.main.decode("mockup_author.json")
    
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
                        Image(article.author)
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    HStack {
                        Text(article.formattedPublishDate)
                        Spacer()
                        Text(article.author)
                    }
                    .font(.caption2)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 18)
                    parseCustomTags(article.body)
                        .padding()
                    HStack {
                        NavigationLink {
                            AuthorView()
                        } label : {
                            HStack {
                                Image(article.author)
                                    .frame(width: 10, height: 10)
                            }
                        }
                    }
                }
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
    
    return ArticleView(article: articles[0])
}
