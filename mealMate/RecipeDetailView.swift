//
//  RecipeDetailView.swift
//  mealMate
//
//  Created by jessiline imanuela on 27/05/24.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var isClicked: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        
//        NavigationView{
//            VStack{
//                NavigationLink(destination: ContentView().navigationBarTitle("Bill Details")) {
//                    Text("Go to Detail View")
//                }
//                .navigationBarBackButtonHidden(false)
//                Spacer()
//            }
//
//        }
        VStack{
            Image("kambingguling")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 320)
                .clipped()
            Spacer()
            ZStack{
                UnevenRoundedRectangle(topLeadingRadius: 35, topTrailingRadius: 35)
                    .foregroundColor(.white)
                    .padding(.top,-20)

                ScrollView{
                    HStack{
                        VStack(alignment: .leading){
                            HStack{
                                Text("Ayam Woku")
                                    .font(.system(size: 28))
                                    .fontWeight(.semibold)
                                Spacer()
                                ZStack {
                                    Circle()
                                        .frame(width: 48, height: 48)
                                        .foregroundColor(isClicked ? Color(red: 220/255, green: 38/255, blue: 38/255) : .white)
                                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 3)

                                    Image(systemName: "heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(isClicked ? .white : Color(red: 220/255, green: 38/255, blue: 38/255))

                                }
                                .onTapGesture {
                                    isClicked.toggle()
                                }
                            }
//                            .padding(.top,15)

                            Text("203 Calories")
                                .font(.system(size: 12))
                                .padding(.bottom)
                            
                                .foregroundColor(.gray)
                            Text("Need to buy:")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .padding(.bottom,1)
                            Text("• 1/2 sendok teh gula\n• 1/4 sendok teh merica bubuk\n• 1 sendok teh kecap ikan\n• 1 sendok teh saus raja rasa\n• 1 sendok teh saus tiram")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14))
                                .lineSpacing(5)
                                .padding(.bottom,10)
                            
                            Text("Ingredients:")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .padding(.bottom,1)
                            Text("• 50 gram ayam potong kotak kecil\n• 200 gram udang besar potong kecil\n• 1 lembar daun bawang iris halus\n• 1/2 sendok teh garam halus/sesuai selera\n• 1/2 sendok teh gula\n• 1/4 sendok teh merica bubuk\n• 1 sendok teh kecap ikan\n• 1 sendok teh saus raja rasa\n• 1 sendok teh saus tiram\n• 1 sendok teh minyak wijen\n• 1 sendok makan tepung sagu\n• 1 sendok teh tepung terigu\n• 1 butir telur ambil bagian putihnya saja, kocok lepas\n• 2 lembar kembang tahu kering / kulit tahu direndam sebentar")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14))
                                .lineSpacing(5)
                                .padding(.bottom,10)
                            
                            Text("Cooking Step:")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .padding(.bottom,2)
                            HStack{
                                VStack{
                                    ZStack{
                                        Circle()
                                            .fill(Color(red: 248/255, green: 235/255, blue: 235/255))
                                            .frame(width: 25, height: 25)
                                        
                                        Circle()
                                            .fill(Color(red: 250/255, green: 183/255, blue: 191/255))
                                            .frame(width: 13, height: 13)
                                    }
                                    Rectangle()
                                       .fill(Color(red: 248/255, green: 235/255, blue: 235/255))
                                       .frame(width: 3, height: 50)
                                       .cornerRadius(2)
                                       .padding(.top,-3)
                                }
                                VStack{
                                    Text("Campur ayam & udang dengan semua bumbu & daun bawang, aduk rata.")
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 14))
                                    Spacer()
                                }
                            }
                            .frame(height: 80)

                            HStack{
                                VStack{
                                    ZStack{
                                        Circle()
                                            .fill(Color(red: 248/255, green: 235/255, blue: 235/255))
                                            .frame(width: 25, height: 25)
                                        
                                        Circle()
                                            .fill(Color(red: 250/255, green: 183/255, blue: 191/255))
                                            .frame(width: 13, height: 13)
                                    }
                                    Rectangle()
                                       .fill(Color(red: 248/255, green: 235/255, blue: 235/255))
                                       .frame(width: 3, height: 50)
                                       .cornerRadius(2)
                                       .padding(.top,-3)
                                }
                                VStack{
                                    Text("Aduk rata, Isikan ke lembaran kulit kembang tahu & lipat seperti melipat lumpia, sambil dipadatkan agar rapi & bentuk agak pipih jangan terlalu bulat.")
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 14))
                                    Spacer()
                                }
                            }
                            .frame(height: 80)

                            HStack{
                                VStack{
                                    ZStack{
                                        Circle()
                                            .fill(Color(red: 248/255, green: 235/255, blue: 235/255))
                                            .frame(width: 25, height: 25)
                                        
                                        Circle()
                                            .fill(Color(red: 250/255, green: 183/255, blue: 191/255))
                                            .frame(width: 13, height: 13)
                                    }
                                    Rectangle()
                                       .fill(Color(red: 255/255, green: 255/255, blue: 255/255))
                                       .frame(width: 3, height: 50)
                                       .cornerRadius(2)
                                       .padding(.top,-3)
                                }
                                VStack{
                                    Text("Olesi putih telur diujung lipatan agar merekat rapat.")
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 14))
                                    Spacer()
                                }
                            }
                            .frame(height: 80)
                        }
                        Spacer()
                    }
                    .padding(.horizontal,32)
                }
            }
            .padding(.top,-15)

            CustomButton(text: "Done Cooking")
                .padding(.top)
            
        }
        .navigationBarItems(trailing:
            NavigationLink(destination: SavedItemsView(isClicked: $isClicked).navigationBarTitle("Saved Items")) {
                    Text("Saved Items")
                }
           )
    }
}

#Preview {
    RecipeDetailView(isClicked: .constant(false))
}
