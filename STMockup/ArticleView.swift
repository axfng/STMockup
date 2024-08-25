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
                    parseCustomTags(article.body)
                        .padding()
                    HStack {
                        // authors
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
