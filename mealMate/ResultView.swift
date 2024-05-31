//
//  ResultView.swift
//  mealMate
//
//  Created by jessiline imanuela on 28/05/24.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isClicked = false
    var body: some View {
        VStack{
            ScrollView{
                VStack(){
                    HStack{
                        Spacer()
                        NavigationLink(destination: RecipeDetailView(isClicked: $isClicked).navigationBarTitle("Recipe Details")) {
                            VStack{
                                Image("kambingguling")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 105)
                                    .clipShape(
                                        UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                                    )
                                ZStack{
                                    UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
                                        .frame(width: 165, height: 110)
                                        .foregroundColor(.white)
                                    VStack{
                                        HStack{
                                            Text("Kambing Guling")
                                                .font(.system(size: 14))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        HStack{
                                            Text("102 Calories")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                                .padding(.top,1)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    .padding(10)
                                    VStack(){
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            ZStack {
                                                Circle()
                                                    .frame(width: 40, height: 40)
                                                    .foregroundColor(isClicked ? Color(red: 220/255, green: 38/255, blue: 38/255) : .white)
                                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 3)
                                                
                                                Image(systemName: "heart")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 18, height: 18)
                                                    .foregroundColor(isClicked ? .white : Color(red: 220/255, green: 38/255, blue: 38/255))
                                                
                                            }
                                            .onTapGesture {
                                                isClicked.toggle()
                                            }
                                            .padding(10)
                                        }
                                    }
                                    
                                }
                                .padding(.top,-9)
                                .frame(maxWidth: 165)
                                
                                
                            }
                        }
                        Spacer()
                        VStack{
                            Image("kambingguling")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 165, height: 105)
                                .clipShape(
                                    UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                                )
                            ZStack{
                                UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
                                    .frame(width: 165, height: 110)
                                    .foregroundColor(.white)
                                VStack{
                                    HStack{
                                        Text("Kambing Guling")
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                    HStack{
                                        Text("102 Calories")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                            .padding(.top,1)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                .padding(10)
                                VStack(){
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        ZStack {
                                            Circle()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(isClicked ? Color(red: 220/255, green: 38/255, blue: 38/255) : .white)
                                                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 3)
                                            
                                            Image(systemName: "heart")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 18, height: 18)
                                                .foregroundColor(isClicked ? .white : Color(red: 220/255, green: 38/255, blue: 38/255))
                                            
                                        }
                                        .onTapGesture {
                                            isClicked.toggle()
                                        }
                                        .padding(10)
                                    }
                                }
                                
                            }
                            .padding(.top,-9)
                            .frame(maxWidth: 165)
                            
                            
                        }
                        
                        Spacer()
                    }
                    .padding(.top,30)
                }

            }

            .frame(maxWidth: .infinity)
            Spacer()
            
            
        }
        .background(Color(red: 244/255, green: 244/255, blue: 244/255))
        .padding(.top,0.2)
        .navigationBarItems(trailing:
                            NavigationLink(destination: SavedItemsView(isClicked: $isClicked).navigationBarTitle("Saved Items")) {
                Text("Saved Items")
            }
       )
    }
}

#Preview {
    ResultView()
}
