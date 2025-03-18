//
//  IHelpEvent.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 1/15/24.
//

import Foundation

struct IHelpEventResponse: Codable {
    let status: String
    let code: Int
    let message: String
    let data: IHelpEventData
}

struct IHelpEventData: Codable {
    let data: [IHelpEvent]
    let pagination: Pagination
}

struct Pagination: Codable {
    let currentPage, perPage: String
    let totalItems, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case perPage = "per_page"
        case totalItems = "total_items"
        case totalPages = "total_pages"
    }
}


struct IHelpEvent: Codable, Identifiable {
    let id, eventTypeID: Int
    let titleEn, titlePh, descriptionEn, descriptionPh: String
    let locationEn, locationPh, eventDateFrom, eventTimeFrom: String
    let eventDateTo, eventTimeTo, status: String
    let createdBy: Int
    let createdAt, updatedAt: String
    let type: TypeClass
    //let media: [String]
    

    enum CodingKeys: String, CodingKey {
        case id
        case eventTypeID = "event_type_id"
        case titleEn = "title_en"
        case titlePh = "title_ph"
        case descriptionEn = "description_en"
        case descriptionPh = "description_ph"
        case locationEn = "location_en"
        case locationPh = "location_ph"
        case eventDateFrom = "event_date_from"
        case eventTimeFrom = "event_time_from"
        case eventDateTo = "event_date_to"
        case eventTimeTo = "event_time_to"
        case status
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case type
        //case media
    }
    
    var startDateString: String {
        if let eventDate = Date(fromString: eventDateFrom + "T" + eventTimeFrom, format: .custom("yyyy-MM-dd'T'HH:mm:ss")) {
            return eventDate.toString(style: .short) ?? ""
        } else {
            return eventDateFrom + " " + eventTimeFrom
        }
    }
    
    var endDateString: String {
        if let eventDate = Date(fromString: eventDateTo + "T" + eventTimeTo, format: .custom("yyyy-MM-dd'T'HH:mm:ss")) {
            return eventDate.toString(style: .short) ?? ""
        } else {
            return eventDateTo + " " + eventTimeTo
        }
    }
    
    var title: String {
        LocalizationService.shared.currentLanguage == .filipino ? titlePh : titleEn
    }
    
    var description: String {
        LocalizationService.shared.currentLanguage == .filipino ? descriptionPh : descriptionEn
    }
    
    var timeWhen: String {
        startDateString + " - " + endDateString
    }
    
    var address: String {
        LocalizationService.shared.currentLanguage == .filipino ? locationPh : locationEn
    }
    
    var eventType: String {
        type.eventTypeEn
    }
    
    //var image
    
    

//    let webLink, image, thumbnail, ticketInfo: String?
//    let createdAt, updatedAt: String
}

// MARK: - TypeClass
struct TypeClass: Codable {
    let id: Int
    let eventTypeEn, typeValue: String

    enum CodingKeys: String, CodingKey {
        case id
        case eventTypeEn = "event_type_en"
        case typeValue = "type_value"
    }
}


// MARK: - IHelpEvent v2 (I designed)
//struct IHelpEvent2: Codable, Identifiable {
//    var id: UUID = UUID()
//    let objectID: String
//    let startDate: DynamicType<Date>
//    let title, description, timeWhen, address: String
//    let webLink, image, thumbnail, ticketInfo: String?
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case objectID = "objectId"
//        case startDate = "start_date"
//        case title, description
//        case timeWhen = "time_when"
//        case address
//        case webLink = "web_link"
//        case image, thumbnail
//        case ticketInfo = "ticket_info"
//        case createdAt, updatedAt
//    }
//}

struct ResponseResults<T: Codable>: Codable {
    
    let results: [T]

    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}


//struct DynamicType<T>: Codable {
//    
//    let type: String
//    let iso: String?
//    
//    var value: T? {
//        
//        switch type {
//        case "Date":
//            
//            guard let iso = iso else { return nil }
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            let date = dateFormatter.date(from: "2024-04-15T10:00:00.000Z")
//            print("date: \(String(describing: date))")
//            return date as? T
//        default:
//            return nil
//        }
//        
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case type = "__type"
//        case iso
//    }
//}



//struct IHelpEvent: Codable {
//    
//    var id: UUID
//    var title: String
//    var description: String
//    var date: Date
//    var time: String
//    var location: String
//    var image: String? // This could also be a URL if you're fetching images from the web
//    var helpline: String
//    var registered: Bool
//    
//    
//    init(id: UUID = UUID(), title: String, description: String, date: Date, time: String, location: String, helpline: String, image: String?, registered: Bool) {
//        self.id = id
//        self.title = title
//        self.description = description
//        self.date = date
//        self.time = time
//        self.location = location
//        self.helpline = helpline
//        self.image = image
//        self.registered = registered
//    }
//    
//    init(event: GoogleEvent) {
//        self.id = UUID()
//        self.title = event.title
//        self.description = event.description
//        self.date = event.date.eventDate
//        self.time = event.date.when
//        self.location = event.address.joined(separator: ", ")
//        self.helpline = "(800) 272-3900"
//        self.image = event.image
//        self.registered = false
//    }
//}

