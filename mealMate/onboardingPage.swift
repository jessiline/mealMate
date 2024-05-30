//
//  onboardingPage.swift
//  mealMate
//
//  Created by Vanessa on 27/05/24.
//

import SwiftUI

struct onboardingPage: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ZStack{
                        Image("onboarding")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 420, height: 410)
                            .padding(.bottom, 20)
                        
                        Image("foodonboarding")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 350)
                            .padding(.bottom, 20)
                    }
                    
                    Text("Find your recipe")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text("Discover the joy of cooking with ingredients you already have. Scan your ingredients and let our app suggest delicious recipes. Save time, reduce waste, and get inspired with MealMate.")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding([.horizontal, .bottom])
                        .ignoresSafeArea()
                    Spacer()
                    NavigationLink(destination: scanPage().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Text("Get Started")
                                .fontWeight(.bold)
                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "DC2626"))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                    }
                    .ignoresSafeArea()
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                    
                    Spacer()
                }
                .padding(.top, 50)
            }
        }
    }
}

#Preview {
    onboardingPage()
}

