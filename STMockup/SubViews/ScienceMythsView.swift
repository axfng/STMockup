//
//  ScienceMythsView.swift
//  STMockup
//
//  Created by alfeng on 8/25/24.
//

import SwiftUI

struct ScienceMythsView: View {
    let authors: [String: Author] = Bundle.main.decode("mockup_author.json")
    let articles: [Article]
    let acceptedArticles: [Article]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(articles: [Article]) {
        self.articles = articles
        self.acceptedArticles = self.articles.filter { $0.category == "Science Myths"}
    }
}

#Preview {
    let articles: [Article] = Bundle.main.decode("mockup_article.json")
    return ScienceMythsView(articles: articles)
}
