//
//  Language.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/6/23.
//

import Foundation
import UIKit

enum Language: String, Equatable, CaseIterable {
    
    case english_us = "en"
    case filipino = "fil"
    
    var name: String {
        switch self {
        case .english_us:
            return "English"
        case .filipino:
            return "Filipino"
        }
    }
    
    init(rawValue: String) {
        switch rawValue {
        case "en":
            self = .english_us
        case "fil":
            self = .filipino
        default:
            self = .english_us
        }
    }
}

class LocalizationService {
    
    public static let shared = LocalizationService()
    
    static let languageOverrideKey = "language.override.code"
    
    var currentBundle: Bundle!
    
    var currentLanguage: Language = getLangauge() {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: LocalizationService.languageOverrideKey)
        }
    }
    

    private init() {
        loadCurrentBundle()
    }

    func loadCurrentBundle() {
        let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj")!
        currentBundle = Bundle(path: path)!
    }
    
    static func getLangauge() -> Language {
        let code = UserDefaults.standard.string(forKey: LocalizationService.languageOverrideKey) ?? Locale.current.language.languageCode?.identifier ?? "en"
        print("let code = UserDefaults.standard.string(forKey: LanguageManager.overrideKey) ?? Locale.current.language.languageCode?.identifier ?? en")
        return Language(rawValue: code)
    }

    func setLanguage(_ language: Language) {
        currentLanguage = language
        loadCurrentBundle()
    }
}


extension String {
    
    func localized( _ language: Language? = nil) -> String {
        
        let bundle: Bundle
        if let language = language {
            if LocalizationService.shared.currentBundle.bundlePath.contains("\(language.rawValue).lproj") {
                bundle = LocalizationService.shared.currentBundle
            } else  {
                let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
                if let path = path {
                    bundle = Bundle(path: path) ?? .main
                } else {
                    bundle = .main
                }
            }
        } else {
            bundle = LocalizationService.shared.currentBundle
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    func localizeWithFormat(_ language: Language? = nil, arguments: CVarArg...) -> String {
        return String(format: self.localized(language), arguments: arguments)
    }
}
