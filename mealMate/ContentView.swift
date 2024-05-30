//
//  ContentView.swift
//  mealMate
//
//  Created by jessiline imanuela on 27/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @State private var size: CGFloat = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        NavigationView {
            ZStack {
                gradientColor
                    .ignoresSafeArea()
                VStack{
                    Image("Pattern")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 350)
                        .clipped()
                        .ignoresSafeArea(edges: .top)
                    Spacer()
                }
                
                VStack {
                    
                    Image("logomealmate")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400, height: 400)
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                self.isActive = true
                            }
                        }
                    
                    
                }
            }
            .background(gradientColor)
        }
        .accentColor(Color.red)
        .fullScreenCover(isPresented: $isActive) {
            onboardingPage()
        }
    }
    
    var gradientColor: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color(hex: "DC2626"), Color(hex: "DC2626")]), startPoint: .top, endPoint: .bottom)
    }
}
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        if scanner.scanHexInt64(&rgbValue) {
            let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = Double(rgbValue & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue)
            return
        }
        
        self.init(red: 0, green: 0, blue: 0)
    }
}

#Preview {
    ContentView()
}

