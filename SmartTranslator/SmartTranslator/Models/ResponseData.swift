//
//  ResponseData.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 13/04/2021.
//

import Foundation

struct ResponseData: Decodable {
    var supportedLangs: [LanguageModel]
}
