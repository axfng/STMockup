//
//  ScienceNewsView.swift
//  STMockup
//
//  Created by alfeng on 8/25/24.
//

import SwiftUI

struct ScienceNewsView: View {
    let authors: [String: Author] = Bundle.main.decode("mockup_author.json")
    var articles: [Article]
    
    let acceptedCategories = ["Health and Medicine", "Chemistry and Biochemstry", "Matter Energy and Astronomy", "Society and Psychology", "Environment and Ecology"]
    var acceptedArticles: [Article]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(acceptedArticles) { article in
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
    }
    init(articles: [Article]) {
        self.articles = articles
        // this can definitely be simplified but I have tried 5 things and they all don't work
        self.acceptedArticles = self.articles.filter {
            $0.category == "Health and Medicine" || $0.category == "Chemistry and Biochemstry" || $0.category == "Matter Energy and Astronomy" || $0.category == "Society and Psychology" || $0.category == "Environment and Ecology"
        }
    }
    
}

#Preview {
    let articles: [Article] = Bundle.main.decode("mockup_article.json")
    return ScienceNewsView(articles: articles)
}
