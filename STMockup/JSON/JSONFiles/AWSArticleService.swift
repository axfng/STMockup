//
//  AWSArticleService.swift
//  STMockup
//
//  Created by alfeng on 10/10/24.
//

import Foundation

struct AWSArticle: Decodable, Identifiable {
    let id: String
    let contributors: String
    let title: String
    let category: String
    let publishDate: String
    let preview: String
    let body: String
    let links: [String]
}

struct ArticleService {
    // Function to fetch articles
    func fetchArticles(completion: @escaping ([AWSArticle]) -> Void) {
        let url = URL(string: "https://kssg5c5qkd.execute-api.us-east-2.amazonaws.com/STArticles")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601  // Assuming your dates are in ISO8601 format
                do {
                    let fetchedArticles = try decoder.decode([AWSArticle].self, from: data)
                    DispatchQueue.main.async {
                        completion(fetchedArticles)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Network error: \(error)")
            }
        }
        task.resume() // Start the request
    }
}
