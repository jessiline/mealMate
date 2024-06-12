//
//  ResultView.swift
//  mealMate
//
//  Created by jessiline imanuela on 28/05/24.
//

import SwiftUI
import SwiftData

struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var ayamData: [AyamData] = []
    @Binding var classificationResults: [String]
    @Environment(\.modelContext) private var context
    @State private var displayedItemCount: Int = 6
    @Binding var allIngredients: [String]
    @State private var showAlert = false

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 175))]) {
                    ForEach(ayamData.prefix(displayedItemCount)) { item in
                        NavigationLink(destination: RecipeDetailView(ayamData: [item], allIngredients: $allIngredients).navigationBarTitle("Recipe Details")) {
                            VStack {
                                if let url = URL(string: "https://\(item.Url)") {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 165, height: 105)
                                    .clipShape(
                                        UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                                    )
                                
                                }

                                ZStack {
                                    UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
                                        .frame(width: 165, height: 110)
                                        .foregroundColor(.white)
                                    VStack {
                                        HStack {
                                            Text(item.Title)
                                                .font(.system(size: 14))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    .padding(10)
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            ZStack {
                                                Circle()
                                                    .frame(width: 40, height: 40)
                                                    .foregroundColor(getHeartColor(for: item))
                                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 3)
                                                
                                                Image(systemName: "heart")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 18, height: 18)
                                                    .foregroundColor(getHeartIconColor(for: item))
                                                
                                            }
                                            .onTapGesture {
                                                let index = ayamData.firstIndex(where: { $0.id == item.id })!
                                                ayamData[index].isClicked.toggle()
                                                if ayamData[index].isClicked {
                                                    addItem(item)
                                                } else {
                                                    deleteItem(item)
                                                }
                                            }
                                            .padding(10)
                                        }
                                    }
                                }
                                .padding(.top, -9)
                                .frame(maxWidth: 165)
                            }
                            .padding(.top)
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                Spacer()
                if displayedItemCount < 20 {
                    CustomButton(text: "See More")
                        .padding(.top)
                        .onTapGesture {
                            displayedItemCount = 20  // Update the count to show 20 items
                        }
                }
            }
            .background(Color(red: 244/255, green: 244/255, blue: 244/255))
            .padding(.top, 0.2)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: SavedItemsView(ayamData: $ayamData, allIngredients: $allIngredients).navigationBarTitle("Saved Items")) {
                    Text("Saved Items")
                }
            )
            .onAppear {
//                print("allIngredients in ResultView: \(allIngredients)")
                guard !classificationResults.isEmpty else {
                    var alertMessage = "Tidak ada hasil klasifikasi yang tersedia"
                    showAlert = true
                    return
                }

                var filename = classificationResults[0]
                filename = filename.replacingOccurrences(of: "daging", with: "").trimmingCharacters(in: .whitespaces)
                filename = "dataset-\(filename)"
                self.ayamData = loadCSV(from: filename)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Warning"),
                    message: Text("Please Input your Ingredients!"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    private func fetchDataItem(with title: String) -> DataItem? {
            let fetchRequest = FetchDescriptor<DataItem>(predicate: #Predicate { dataItem in
                dataItem.Title == title
            })
            
            do {
                return try context.fetch(fetchRequest).first
            } catch {
                print("Failed to fetch data item: \(error.localizedDescription)")
                return nil
            }
        }
        
        private func getHeartColor(for item: AyamData) -> Color {
            if let dataItem = fetchDataItem(with: item.Title) {
                return dataItem.isClicked ? .white : Color(red: 220/255, green: 38/255, blue: 38/255)
            } else {
                return item.isClicked ? Color(red: 220/255, green: 38/255, blue: 38/255) : .white
            }
        }
        
        private func getHeartIconColor(for item: AyamData) -> Color {
            if let dataItem = fetchDataItem(with: item.Title) {
                return dataItem.isClicked ? Color(red: 220/255, green: 38/255, blue: 38/255) : .white
            } else {
                return item.isClicked ? .white : Color(red: 220/255, green: 38/255, blue: 38/255)
            }
        }
        
        func addItem(_ item: AyamData) {
            let dataItem = DataItem(id: item.id.uuidString, Title: item.Title, Ingredients: item.Ingredients, Steps: item.Steps, Url: item.Url, isClicked: item.isClicked)
            dataItem.isClicked = item.isClicked

            context.insert(dataItem)
                    
            do {
                try context.save()
            } catch {
                print("Failed to save item: \(error.localizedDescription)")
            }
        }

        private func deleteItem(_ item: AyamData) {
            
            let itemTitleString = item.Title
            let fetchRequest = FetchDescriptor<DataItem>(predicate: #Predicate { dataItem in
                dataItem.Title == itemTitleString
            })
            
            do {
                let items = try context.fetch(fetchRequest)
                for dataItem in items {
                    context.delete(dataItem)
                }
                try context.save()
            } catch {
                print("Failed to delete item: \(error.localizedDescription)")
            }
        }
}
