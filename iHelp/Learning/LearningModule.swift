//
//  LearningModule.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/30/23.
//

import Foundation


struct LearningModuleResponse: Codable {
    let status: String
    let code: Int
    let message: String
    let data: [LearningModule]
}

// MARK: - Datum
struct LearningModule: Codable, Identifiable {
    let id = UUID()
    
    let moduleID: Int
    let type, title, description: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case moduleID = "module_id"
        case type, title, description, link
    }
    
    static func getLearningModules() -> [LearningModule] {
        let jsonData = Data(learningModuleJSONData.utf8)
        let decoder = JSONDecoder()
        let response = try! decoder.decode(LearningModuleResponse.self, from: jsonData)
        return response.data
    }
}

let learningModuleJSONData =
"""
{
  "status": "success",
  "code": 200,
  "message": "List of Education Training Modules retrieved successfully",
  "data": [
    {
        "module_id": 2,
        "type": "website",
        "subtype": "literacy",
        "title": "Alzheimer's Facts and Figures",
        "description": "",
        "link": "https://www.alz.org/alzheimers-dementia/facts-figures"
    },
    {
        "module_id": 3,
        "type": "website",
        "subtype": "literacy",
        "title": "Causes and Risk Factors for Alzheimer's Disease",
        "description": "",
        "link": "https://www.alz.org/alzheimers-dementia/what-is-alzheimers/causes-and-risk-factors"
    },
    {
        "module_id": 4,
        "type": "website",
        "subtype": "literacy",
        "title": "Dementia",
        "description": "",
        "link": "https://www.alz.org/alzheimers-dementia/what-is-dementia"
    },
    {
        "module_id": 5,
        "type": "website",
        "subtype": "literacy",
        "title": "Alzheimer's Disease",
        "description": "",
        "link": "https://www.alz.org/alzheimers-dementia/what-is-alzheimers"
    },
    {
        "module_id": 6,
        "type": "website",
        "subtype": "literacy",
        "title": "How Alzheimer's Diagnosed?",
        "description": "",
        "link": "https://www.alz.org/alzheimers-dementia/diagnosis/medical_tests"
    },
    {
        "module_id": 7,
        "type": "website",
        "subtype": "literacy",
        "title": "Stages of Alzheimer's",
        "description": "",
        "link": "https://www.alz.org/alzheimers-dementia/stages"
    },
    {
        "module_id": 8,
        "type": "website",
        "subtype": "literacy",
        "title": "Why Get Checked?",
        "description": "",
        "link": "https://www.alz.org/alzheimers-dementia/diagnosis/why-get-checked"
    },
    {
        "module_id": 9,
        "type": "website",
        "subtype": "literacy",
        "title": "Treatments for Alzheimer's",
        "description": "",
        "link": "https://www.alz.org/alzheimers-dementia/treatments"
    }
]
}
"""
