//
//  Styles.swift
//  STMockup
//
//  Created by alfeng on 8/31/24.
//

import SwiftUI

struct Styles: View {
    var body: some View {
        ScrollView {
            Text("Custom Formatting")
                .font(.largeTitle.bold())
            VStack{
                Text("This is a caption for article or author previews")
                    .sTCaption()
            }
            
        }
    }
}

struct STCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color(red: 0.2, green: 0.2, blue: 0.2))
            .font(.caption)
            .lineLimit(4)
            .multilineTextAlignment(.leading)
    }
}

extension View {
    func sTCaption() -> some View {
        modifier(STCaption())
    }
}

#Preview {
    Styles()
}
