//
//  Author.swift
//  STMockup
//
//  Created by alfeng on 8/28/24.
//

import Foundation

struct Author: Codable, Identifiable {
    let id: String
    let joinDate: Date?
    let bio: String
    
    var image: String {
        id
    }
    
    var formattedPublishDate: String {
        joinDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
