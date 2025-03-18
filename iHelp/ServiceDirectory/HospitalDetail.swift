//
//  Hospital.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 5/8/24.
//

import Foundation
import MapKit


// MARK: - Welcome
struct HopspitalResponse: Codable {
    let results: [Hospital]
    let limit, total, page, pages: Int
    let allMatchingProviderIDS: [String]

    enum CodingKeys: String, CodingKey {
        case results, limit, total, page, pages
        case allMatchingProviderIDS = "allMatchingProviderIds"
    }
}

// MARK: - Result
struct Hospital: Codable, Identifiable {
    let lon, lat: Double
    let geom: Geom
    let distance: Double
    let name: String
    //let hospitalID: String
    let type: ResultType
    let providerID, sortName: String
    let firstName, lastName: String?
    //let specialties: String?
    let addressState: AddressState
    let isDuplicateAddress, isCanonicalAddress: Bool
    let resultSortName: String
    let hospital: HospitalDetail
    
    let id = UUID()
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

    enum CodingKeys: String, CodingKey {
        case lon, lat, geom, distance, name, id, type
        case providerID = "providerId"
        //case hospitalID = "id"
        case sortName, firstName, lastName, addressState, isDuplicateAddress, isCanonicalAddress
        //case specialties
        case resultSortName = "sort_name"
        case hospital
    }
    
    static func getHospitals() -> [Hospital] {
        
        let jsonData = readJSONFile(forName: "hospitals")!
        
        let decoder = JSONDecoder()
        let response = try! decoder.decode(HopspitalResponse.self, from: jsonData)
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
}

enum AddressState: String, Codable {
    case ga = "GA"
}

// MARK: - Geom
struct Geom: Codable {
    let crs: CRS
    let type: GeomType
    let coordinates: [Double]
}

// MARK: - CRS
struct CRS: Codable {
    let type: CRSType
    let properties: Properties
}

// MARK: - Properties
struct Properties: Codable {
    let name: Name
}

enum Name: String, Codable {
    case epsg4326 = "EPSG:4326"
}

enum CRSType: String, Codable {
    case name = "name"
}

enum GeomType: String, Codable {
    case point = "Point"
}

// MARK: - Hospital
struct HospitalDetail: Codable {
    let overallRatingFootnotes, mortalityGroupFootnotes, safetyGroupFootnotes, readmissionGroupFootnotes: [Footnote]?
    let timelyAndEffectiveCareGroupFootnotes, patientExperienceGroupFootnotes: [Footnote]?
    let dateImported, hash, id, providerID: String
    let addressLine1, addressCity: String
    let addressState: AddressState
    let addressZipcode, phone: String
    let geocodeSource: GeocodeSource
    let lon, lat: Double
    let name, hospitalType, ownership: String
    let meetsCriteriaForMeaningfulUseOfEhrs, meetsCriteriaForBirthingFriendlyDesignation, hasEmergencyServices: Bool
    let overallRating: String
    let overallRatingFootnote: String?
    let dataSource: DataSource
    let facilityMortalityMeasuresCount, mortalityGroupMeasureCount, mortalityMeasuresBetterCount, mortalityMeasuresNoDifferentCount: String
    let mortalityMeasuresWorseCount: String
    let mortalityGroupFootnote: String?
    let facilitySafetyMeasuresCount, safetyGroupMeasureCount, safetyMeasuresBetterCount, safetyMeasuresNoDifferentCount: String
    let safetyMeasuresWorseCount: String
    let safetyGroupFootnote: String?
    let facilityReadmissionMeasuresCount, readmissionGroupMeasureCount, readmissionMeasuresBetterCount, readmissionMeasuresNoDifferentCount: String
    let readmissionMeasuresWorseCount: String
    let readmissionGroupFootnote: String?
    let facilityTimelyAndEffectiveCareMeasuresCount, timelyAndEffectiveCareGroupMeasureCount: String
    let timelyAndEffectiveCareGroupFootnote: String?
    let facilityPatientExperienceMeasureCount, patientExperienceGroupMeasureCount: String
    let patientExperienceGroupFootnote: String?
    //let patientSurveys: [PatientSurvey]

    enum CodingKeys: String, CodingKey {
        case overallRatingFootnotes, mortalityGroupFootnotes, safetyGroupFootnotes, readmissionGroupFootnotes, timelyAndEffectiveCareGroupFootnotes, patientExperienceGroupFootnotes, dateImported, hash, id
        case providerID = "providerId"
        case addressLine1, addressCity, addressState, addressZipcode, phone, geocodeSource, lon, lat, name, hospitalType, ownership, meetsCriteriaForMeaningfulUseOfEhrs, meetsCriteriaForBirthingFriendlyDesignation, hasEmergencyServices, overallRating, overallRatingFootnote, dataSource, facilityMortalityMeasuresCount, mortalityGroupMeasureCount, mortalityMeasuresBetterCount, mortalityMeasuresNoDifferentCount, mortalityMeasuresWorseCount, mortalityGroupFootnote, facilitySafetyMeasuresCount, safetyGroupMeasureCount, safetyMeasuresBetterCount, safetyMeasuresNoDifferentCount, safetyMeasuresWorseCount, safetyGroupFootnote, facilityReadmissionMeasuresCount, readmissionGroupMeasureCount, readmissionMeasuresBetterCount, readmissionMeasuresNoDifferentCount, readmissionMeasuresWorseCount, readmissionGroupFootnote, facilityTimelyAndEffectiveCareMeasuresCount, timelyAndEffectiveCareGroupMeasureCount, timelyAndEffectiveCareGroupFootnote, facilityPatientExperienceMeasureCount, patientExperienceGroupMeasureCount, patientExperienceGroupFootnote
        //case patientSurveys
    }
}

enum DataSource: String, Codable {
    case hospitalMainFeed = "HOSPITAL_MAIN_FEED"
}

enum GeocodeSource: String, Codable {
    case smartystreetsStrict = "smartystreets_strict"
}

// MARK: - Footnote
struct Footnote: Codable {
    let code: Int
    let footnote: String
}

// MARK: - PatientSurvey
//struct PatientSurvey: Codable {
//    let starRatingFootnotes: [Footnote]?
//    let answerPercentFootnotes, numberCompletedSurveysFootnotes, surveyResponseRateFootnotes: JSONNull?
//    let id: ID?
//    let starRatingFootnote: String?
//    let starRating: String?
//}

// MARK: - ID
struct ID: Codable {
    let val: String
}

enum ResultType: String, Codable {
    case hospital = "Hospital"
}

// MARK: - Encode/decode helpers
