//
//  dataset.swift
//  mealMate
//
//  Created by jessiline imanuela on 05/06/24.
//
import Foundation

//import SwiftUI
struct AyamData: Identifiable {
    let id = UUID()
    let Title: String
    let Ingredients: String
    let Steps: String
    let Url: String
    var isClicked = false

}

func loadCSV(from filename: String) -> [AyamData] {
    var ayamDataArray: [AyamData] = []

    guard let filePath = Bundle.main.path(forResource: filename, ofType: "csv") else {
        print("File tidak ditemukan")
        return ayamDataArray
    }

    do {
        let content = try String(contentsOfFile: filePath)
        let rows = content.components(separatedBy: "\n")
        let dataRows = rows.dropFirst()

        for row in dataRows {
            let columns = row.components(separatedBy: ";")
            if columns.count >= 3 {
                let ayamData = AyamData(Title: columns[0], Ingredients: columns[1], Steps: columns[2], Url: columns[3])
                ayamDataArray.append(ayamData)
            }
        }
    } catch {
        print("Error membaca file: \(error)")
    }

    return ayamDataArray
}
