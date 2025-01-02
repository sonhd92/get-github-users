//
//  StatsView.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 2/1/25.
//

import SwiftUI

struct StatsView: View {
    let title: String
    let value: Int
    
    var body: some View {
        VStack {
            Image("followers", bundle: .main)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .background(Color(uiColor: UIColor.lightGray.withAlphaComponent(0.5)))
                .clipped()
                .clipShape(Circle())
            
            Text("\(value)")
                .font(.headline)
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StatsView(title: "Title", value: 10)
}
