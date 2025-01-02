//
//  TymeXAssignmentApp.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 31/12/24.
//

import SwiftUI

@main
struct TymeXAssignmentApp: App {
    private let services = ServiceManager()
    var body: some Scene {
        WindowGroup {
            UserListView(service: services)
        }
    }
}
