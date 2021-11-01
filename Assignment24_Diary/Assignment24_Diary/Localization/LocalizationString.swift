//
//  LocalizationString.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import Foundation

enum LocalizationString: String {
    case HomeVC_Title
    case AddVC_Title
    case AddVC_SaveButton_Title
    case AddVC_AddTitle_Placeholder
    case AddVC_SaveButton_DateFormat
    case SearchVC_Title
    case SearchAC_TableView_Extension_Title
    case SearchAC_TableView_Extension_Content
    
    var localized: String {
        return self.rawValue.localized
    }
}
