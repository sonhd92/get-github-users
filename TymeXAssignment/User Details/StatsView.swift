//
//  StatsView.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 2/1/25.
//

import SwiftUI

enum StatsType {
    case followers
    case following
    
    var icon: String {
        switch self {
        case .followers:
            return "followers"
        case .following:
            return "following"
        }
    }
    
    var title: String {
        switch self {
        case .followers:
            return "Followers"
        case .following:
            return "Following"
        }
    }
}

struct StatsView: View {
    let type: StatsType
    let value: Int
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(Color(uiColor: UIColor.lightGray.withAlphaComponent(0.3)))
                
                Image(type.icon, bundle: .main)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .clipShape(Circle())
            }
            
            Text("\(value)")
                .font(.headline)
            Text(type.title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StatsView(type: .followers, value: 10)
}
