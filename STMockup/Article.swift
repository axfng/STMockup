//
//  Article.swift
//  STMockup
//
//  Created by alfeng on 8/25/24.
//

import Foundation

struct Article: Codable, Identifiable {
    let id: String
    let author: String
    let title: String
    let publishDate: Date?
    let body: String
    
    var image: String {
        id
    }
    
    var formattedPublishDate: String {
        publishDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
}
