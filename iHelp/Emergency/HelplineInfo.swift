//
//  HelplineInfo.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/30/23.
//

import Foundation

struct HelplineInfoResponse: Codable {
    let status: String
    let code: Int
    let message: String
    let data: [HelplineInfo]
}


// MARK: - DataClass
struct HelplineInfo: Codable, Identifiable {
    let id = UUID()
    let organization: String
    let helplineNumber: String
    let textNumber: String?
    let email: String
    let physicalAddress: String?
    let operatingHours: String
    let languagesSupported: [String]
    //let emergencyCategories: [String]
    //let additionalResources: AdditionalResources
    let contactUsUrl: String

    enum CodingKeys: String, CodingKey {
        case organization
        case helplineNumber = "helpline_number"
        case textNumber = "text_number"
        case email
        case physicalAddress = "physical_address"
        case operatingHours = "operating_hours"
        case languagesSupported = "languages_supported"
        //case emergencyCategories = "emergency_categories"
        //case additionalResources = "additional_resources"
        case contactUsUrl = "contact_us_url"
    }
}

// MARK: - AdditionalResources
/*
struct AdditionalResources: Codable {
    let faqURL, userGuideURL: String

    enum CodingKeys: String, CodingKey {
        case faqURL = "faq_url"
        case userGuideURL = "user_guide_url"
    }
}*/


let HelplineInfoJsonString =
"""
{
    "status": "success",
    "code": 200,
    "message": "Helpline information retrieved successfully",
    "data": [
        {
            "organization": "Alzheimer's Association",
            "helpline_number": "+1-800-272-3900",
            "text_number": null,
            "email": "info@alz.org",
            "physical_address": "225 N. Michigan Ave. Floor 17 Chicago, IL 60601",
            "operating_hours": "24/7 ",
            "languages_supported": [
                "English",
                "Español"
            ],
            "contact_us_url": "https://www.alz.org/Contact-Us",
        },
        {
            "organization": "Alzheimer's Foundation of America",
            "helpline_number": "+1-866-232-8484",
            "text_number": "+1-646-586-5283",
            "email": "info@alzfdn.org",
            "physical_address": "322 Eighth Avenue, 16th Floor, New York, NY 10001",
            "operating_hours": "The AFA Helpline is open from 9 am-9 pm ET, seven days a week. Connect with a licensed social worker by:",
            "languages_supported": [
                "English",
                "Español"
            ],
            "contact_us_url": "https://alzfdn.org/contact-us/",
        }
    ]
}
"""




