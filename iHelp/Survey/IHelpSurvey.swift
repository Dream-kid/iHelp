//
//  IHelpSurvey.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 3/20/24.
//

import Foundation

struct IHelpSurveyResponse: Codable {
    let status: String
    let code: Int
    let message: String
    let data: IHelpSurveyData
}

struct IHelpSurveyData: Codable {
    let data: [IHelpSurvey]
    //let pagination: Pagination
}

struct IHelpSurvey: Codable, Identifiable, Hashable {
    let id: Int
    let titleEn: String
    let descriptionEn, titlePh, descriptionPh: String?
    let startDate, endDate: String
    let participatorRole: Int
    let status: String
    let providerType: Int?
    let surveyLink: String?
    let createdBy: Int
    let createdAt, updatedAt: String
    let hasResponse: Bool
    let responsedDate: String?
    //let surveyResoponseID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case titleEn = "title_en"
        case descriptionEn = "description_en"
        case titlePh = "title_ph"
        case descriptionPh = "description_ph"
        case startDate = "start_date"
        case endDate = "end_date"
        case participatorRole = "participator_role"
        case status
        case providerType = "provider_type"
        case surveyLink = "survey_link"
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hasResponse, responsedDate
        //case surveyResoponseID = "surveyResoponseId"
    }
    
    var title: String {
        (LocalizationService.shared.currentLanguage == .filipino ? titlePh : titleEn) ?? ""
    }
    
    var subtitle: String {
        (LocalizationService.shared.currentLanguage == .filipino ? descriptionPh : descriptionEn) ?? ""
    }

    var link: String {
        surveyLink ?? ""
    }
}



//struct IHelpSurvey: Codable, Identifiable, Hashable {
//    var id: UUID = UUID()
//    let title: String
//    let subtitle: String
//    let link: String
//    
//    enum CodingKeys: String, CodingKey {
//        case title
//        case subtitle
//        case link
//    }
//}


//{
//  "results": [
//    {
//      "title": "Dementia Knowledge Survey for Nurses",
//      "subtitle":  "Enhance understanding among Filipino and Filipino American nurses. Confidential, voluntary, 15-minute study.",
//      "link": "https://kennesaw.co1.qualtrics.com/jfe/form/SV_7NUwkMvnDrzFgCa"
//    },
//    {
//      "title": "Care Partner Program Survey",
//      "subtitle":  "Share your insights on Filipino American caregiving. Confidential and voluntary, 15-30 minutes.",
//      "link": "https://kennesaw.co1.qualtrics.com/jfe/form/SV_d13I3Gs6HTc7SRw"
//    }
//  ]
//}
