//
//  GoogleEvent.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 6/12/24.
//

import Foundation

//MARK: - Google Events

struct GoogleEventResults: Codable {
    let results: [GoogleEvent]
    
    static func GetEvents() -> [GoogleEvent] {
        
//        let jsonUrl = URL.documentsDirectory().appendingPathComponent("google-ad-events.json")
//        let jsonData = try Data(contentsOf: jsonUrl)
        
        let jsonData = readJSONFile(forName: "google-ad-events")!
        
        let decoder = JSONDecoder()
        let response = try! decoder.decode(GoogleEventResults.self, from: jsonData)
        return response.results
        
        func readJSONFile(forName name: String) -> Data? {
            do {
                if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    return jsonData
                } else {
                    return nil
                }
            } catch {
                print(error)
                return nil
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

// MARK: - EventsResult
struct GoogleEvent: Codable, Identifiable {
    var id: UUID = UUID()
    let title: String
    let date: DateClass
    let address: [String]
    let link: String
    let eventLocationMap: EventLocationMap
    let description: String
    let ticketInfo: [TicketInfo]
    let thumbnail: String
    let image: String?
    let venue: Venue?

    enum CodingKeys: String, CodingKey {
        case title, date, address, link
        case eventLocationMap = "event_location_map"
        case description
        case ticketInfo = "ticket_info"
        case thumbnail, image, venue
    }
}

// MARK: - DateClass
struct DateClass: Codable {
    let startDate, when: String

    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case when
    }
    
    var eventDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "MMM dd"
        let date = dateFormatter.date(from: startDate)!
        return date
    }
    
}

// MARK: - EventLocationMap
struct EventLocationMap: Codable {
    let image, link: String
    let serpapiLink: String

    enum CodingKeys: String, CodingKey {
        case image, link
        case serpapiLink = "serpapi_link"
    }
}

// MARK: - TicketInfo
struct TicketInfo: Codable {
    let source: String
    let link: String
    let linkType: LinkType

    enum CodingKeys: String, CodingKey {
        case source, link
        case linkType = "link_type"
    }
}

enum LinkType: String, Codable {
    case moreInfo = "more info"
    case tickets = "tickets"
}

// MARK: - Venue
struct Venue: Codable {
    let name: String
    let reviews: Int
    let link: String
}
