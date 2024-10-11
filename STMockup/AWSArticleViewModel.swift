//
//  AWSArticleViewModel.swift
//  STMockup
//
//  Created by alfeng on 10/10/24.
//

import Foundation

class ArticlesViewModel: ObservableObject {
    @Published var articles: [AWSArticle] = []
    
    private let articleService = ArticleService()
    
    // Function to load articles
    func loadArticles() {
        articleService.fetchArticles { articles in
            self.articles = articles
        }
    }
    func loadImages(id: String, index: Int) -> String {
        for article in articles {
            if article.id == id {
                return article.links[index]
            }
        }
        return ""
    }
}
