//
//  SplashView.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 04/04/26.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        ZStack {
            
            if isActive {
                ContentView()
                    .transition(.opacity)
            }
            
            if !isActive {
                Color.black.ignoresSafeArea()
                
                Image("portal")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 800, height: 800)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        
                        withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                            rotation = 360
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            
                            withAnimation(.easeIn(duration: 0.6)) {
                                scale = 3.5
                                opacity = 0.0  
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isActive = true
                            }
                        }
                    }
            }
        }
    }
}
