//
//  AWSArticleView.swift
//  STMockup
//
//  Created by alfeng on 10/10/24.
//

import SwiftUI

struct AWSArticleView: View {
    @StateObject private var viewModel = ArticlesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: viewModel.loadImages(id: article.id, index: 0))) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Text("There was an error loading the image")
                        } else {
                            ProgressView()
                        }
                    }
                    Text(article.title)
                        .font(.headline)
                    parseCustomTags(article.body)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Articles")
            .onAppear {
                viewModel.loadArticles() // Load articles when the view appears
            }
        }
    }
    
    func parseCustomTags(_ text: String) -> some View {
        // Array to hold the views (text and images)
        var views: [AnyView] = []
        
        // First handle the bold tags <b></b>
        let components = text.components(separatedBy: "<b>")
        
        for component in components {
            if component.contains("</b>") {
                let boldParts = component.components(separatedBy: "</b>")
                views.append(AnyView(Text(boldParts[0]).bold()))
                // Process the remaining part of the string (after </b>)
                processTextAndImages(boldParts[1], into: &views)
            } else {
                processTextAndImages(component, into: &views)
            }
        }
        
        // Return the combined views as a VStack
        return VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<views.count, id: \.self) { index in
                views[index]
            }
        }
    }

    func processTextAndImages(_ text: String, into views: inout [AnyView]) {
        // Split the text based on <img> tags
        let components = text.components(separatedBy: "<img>")
        
        for (index, component) in components.enumerated() {
            if component.contains("</img>") {
                let imgParts = component.components(separatedBy: "</img>")
                
                // Add the text part before the image
                if !imgParts[0].isEmpty && index == 0 { // Only add text if it's not inside <img> and </img>
                    views.append(AnyView(Text(imgParts[0])))
                }
                
                // Extract and validate the image URL (from the part inside <img> </img>)
                let imageUrlString = imgParts[0].trimmingCharacters(in: .whitespacesAndNewlines)
                if let imageUrl = URL(string: imageUrlString) {
                    views.append(AnyView(
                        AsyncImage(url: imageUrl) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                            } else if phase.error != nil {
                                Text("There was an error loading the image")
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(height: 200) // Set image height
                    ))
                }
                
                // Process any text remaining after the image tag
                if imgParts.count > 1 && !imgParts[1].isEmpty {
                    let remainingText = imgParts[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    if !remainingText.isEmpty {
                        processTextAndImages(remainingText, into: &views)
                    }
                }
            } else {
                // Add regular text if there's no image tag
                if !component.isEmpty {
                    views.append(AnyView(Text(component)))
                }
            }
        }
    }
}

#Preview {
    AWSArticleView()
}
