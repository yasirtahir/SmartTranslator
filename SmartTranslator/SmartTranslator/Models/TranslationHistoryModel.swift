//
//  TranslationHistoryModel.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 14/04/2021.
//

import Foundation


class TranslationHistoryModel: NSObject, NSCoding {
    
    var dateTime: String
    var fromText: String
    var toText: String
    var fromLang: String
    var toLang: String

    init(dateTime: String, fromText: String, toText: String, fromLang: String, toLang: String) {
        self.dateTime = dateTime
        self.fromText = fromText
        self.toText = toText
        self.fromLang = fromLang
        self.toLang = toLang
    }

    required convenience init(coder aDecoder: NSCoder) {
        let dateTime = aDecoder.decodeObject(forKey: "dateTime") as! String
        let fromText = aDecoder.decodeObject(forKey: "fromText") as! String
        let toText = aDecoder.decodeObject(forKey: "toText") as! String
        let fromLang = aDecoder.decodeObject(forKey: "fromLang") as! String
        let toLang = aDecoder.decodeObject(forKey: "toLang") as! String
        self.init(dateTime: dateTime, fromText: fromText, toText: toText, fromLang: fromLang, toLang: toLang)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(dateTime, forKey: "dateTime")
        aCoder.encode(fromText, forKey: "fromText")
        aCoder.encode(toText, forKey: "toText")
        aCoder.encode(fromLang, forKey: "fromLang")
        aCoder.encode(toLang, forKey: "toLang")
    }
}
