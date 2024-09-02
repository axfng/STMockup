//
//  Article.swift
//  STMockup
//
//  Created by alfeng on 8/25/24.
//

import Foundation

struct Article: Codable, Identifiable {
    struct AuthorInfo: Codable {
        let name: String
    }
    
    let id: String
    let contributors: [AuthorInfo]
    let title: String
    let category: String
    let publishDate: Date?
    let preview: String
    let body: String
    
    var image: String {
        id
    }
    
    var formattedPublishDate: String {
        publishDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
}
