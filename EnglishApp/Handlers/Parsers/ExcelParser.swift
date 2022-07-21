//
//  ExcelParser.swift
//  EnglishApp
//
//  Created by Igoryok on 17.05.2022.
//

import Foundation
import SwiftUI
import CoreXLSX

class ExcelParser {
    public static func getLearningCategories(data: Data) throws -> [LearningCategory] {
        guard let file = try? XLSXFile(data: data) else {
            fatalError("XLSX file is corrupted or does not exist")
        }
        
        var learningCategories: [LearningCategory] = []
        for workbook in try file.parseWorkbooks() {
            for (worksheetName, path) in try file.parseWorksheetPathsAndNames(workbook: workbook) {
                let worksheet = try file.parseWorksheet(at: path)
                
                var wordPairs: [WordPair] = []
                if let sharedStrings = try file.parseSharedStrings() {
                    for row in worksheet.data?.rows ?? [] {
                        wordPairs.append(WordPair(row.cells[0].stringValue(sharedStrings)!, row.cells[1].stringValue(sharedStrings)!))
                    }
                
                    // TODO handle errors
                    let label = LearningCategory.Label(
                        iconPath: worksheet.cells(atColumns: [ColumnReference("D")!])[1].stringValue(sharedStrings)!,
                        titleText: worksheet.cells(atColumns: [ColumnReference("E")!])[1].stringValue(sharedStrings)!,
                        headlineText: worksheet.cells(atColumns: [ColumnReference("F")!])[1].stringValue(sharedStrings)!,
                        backgroundColor: Color(UIColor(hexString: worksheet.cells(atColumns: [ColumnReference("G")!])[1].stringValue(sharedStrings)!))
                    )
                    learningCategories.append(LearningCategory(
                        label: label,
                        wordPairs: wordPairs
                    ))
                }
            }
        }
        
        return learningCategories
    }
}
