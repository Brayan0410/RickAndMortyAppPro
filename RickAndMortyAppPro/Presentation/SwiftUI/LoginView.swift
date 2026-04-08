//
//  LoginView.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 08/04/26.
//

import SwiftUI

struct SimpleLoginView: View {
    
    @EnvironmentObject var authManager: SimpleAuthManager
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
            LinearGradient(
                colors: [Color.green, Color.yellow],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                
                VStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                    
                    Text("Rick & Morty")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Bienvenido")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    
                    TextField("Usuario", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                    
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                    
                    Button(action: {
                        authManager.login()
                    }) {
                        Text("Entrar")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                    }
                }
                
                Spacer()
                Spacer()
            }
            }
            .navigationDestination(isPresented: $authManager.isAuthenticated) {
                AppFactory.shared.makeCharacterListView()
            }
        }
    }
}

#Preview {
    SimpleLoginView()
        .environmentObject(SimpleAuthManager())
}
