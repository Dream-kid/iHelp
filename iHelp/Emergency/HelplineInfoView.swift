//
//  HelplineInfoView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/30/23.
//

import SwiftUI
//import MapKit

struct HelplineInfoView: View {
    
    private var helplineInfos: [HelplineInfo] = {
        let jsonData = Data(HelplineInfoJsonString.utf8)
        let decoder = JSONDecoder()
        let response = try! decoder.decode(HelplineInfoResponse.self, from: jsonData)
        return response.data
    }()
    
    /*
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.9377246, longitude: -84.5187494), // Center coordinates
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Zoom level
    )
    
    let annotations = [
        Location(name: "iHelp", coordinate: CLLocationCoordinate2D(latitude: 33.9377246, longitude: -84.5187494))
    ]
    
    init() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 33.9377246, longitude: -84.5187494)
        annotation.title = "Big Sur"
        
        MKMapView.appearance().addAnnotation(annotation)
    }*/
    
    
    var body: some View {
        
        ScrollView {
            VStack {
                ForEach(helplineInfos) { helplineInfo in
                    OrganizationInfoCard(helplineInfo: helplineInfo)
                    
                }
            }
            
        }

    }
    
}


struct OrganizationInfoCard: View {
    
    let helplineInfo: HelplineInfo
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(helplineInfo.organization)
                .font(.title)
                .fontWeight(.semibold)
            //.padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color("secondary"))
            
            
            if let physicalAddress = helplineInfo.physicalAddress {
                Text(physicalAddress)
                    .fontWeight(.light)
                    .font(.subheadline)
            }
            
            HStack(alignment: .top, spacing: 0) {
                Text("Operating: ")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                + Text(helplineInfo.operatingHours)
                    .fontWeight(.regular)
                    .font(.subheadline)
            }.padding(.top, 8)

            
            
            Button {
                initiateCall(phoneNumber: helplineInfo.helplineNumber)
            } label: {
                HStack {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 20))
                        .padding(.leading, 6)
                    Spacer()
                    Text(helplineInfo.helplineNumber)
                        .font(.headline)
                    Spacer()
                }
                .padding(10)
                .background(Color("primary"))
                .foregroundColor(.white)
                .cornerRadius(6)
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
            
            
            Button {
                initiateCall(phoneNumber: helplineInfo.helplineNumber)
            } label: {
                HStack {
                    Image(systemName: "envelope.fill")
                        .font(.system(size: 20))
                        .padding(.leading, 6)
                    Spacer()
                    Text(helplineInfo.email)
                        .font(.headline)
                    Spacer()
                }
                .padding(10)
                .background(Color("primary"))
                .foregroundColor(.white)
                .cornerRadius(6)
            }
            .padding(.horizontal, 32)
            .padding(.top, 12)
            
            
            if let textNumber = helplineInfo.textNumber {
                Button {
                    initiateTextMessage(phoneNumber: helplineInfo.helplineNumber)
                } label: {
                    HStack {
                        Image(systemName: "message.fill")
                            .font(.system(size: 20))
                            .padding(.leading, 6)
                        Spacer()
                        Text(textNumber)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(10)
                    .background(Color("primary"))
                    .foregroundColor(.white)
                    .cornerRadius(6)
                }
                .padding(.horizontal, 32)
                .padding(.top, 12)
            }

            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color("card-bg")))
        .padding()
        
    }
    
    func initiateCall(phoneNumber: String) {
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
    
    
    func initiateTextMessage(phoneNumber: String) {
        //if let url = URL(string: "sms://" + phoneNumber + "&body= from iPhone") {
        if let phoneURL = URL(string: "sms://\(phoneNumber)") {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
}



#Preview {
    HelplineInfoView()
}


/*
extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}


struct PlaceAnnotationView: View {
  let title: String
  
  var body: some View {
    VStack(spacing: 0) {
      Text(title)
        .font(.callout)
        .padding(5)
        .background(Color(.white))
        .cornerRadius(10)
      
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.red)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.red)
        .offset(x: 0, y: -5)
    }
  }
}
*/
