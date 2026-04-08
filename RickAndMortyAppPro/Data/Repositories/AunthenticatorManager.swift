//
//  SimpleAuthManager.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 08/04/26.
//

import Foundation
import Combine

@MainActor
final class SimpleAuthManager: ObservableObject {
    
    @Published var isAuthenticated = false
    
    func login() {
        isAuthenticated = true
    }
}
