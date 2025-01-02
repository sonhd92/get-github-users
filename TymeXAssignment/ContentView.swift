//
//  ContentView.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 31/12/24.
//

import SwiftUI

struct ContentView: View {
    private let services = ServiceManager()
    
    var body: some View {
        NavigationView {
            Button("Github users") {
                UserListView(service: services)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
