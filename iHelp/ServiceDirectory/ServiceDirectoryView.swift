//
//  ServiceDirectoryView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 5/1/24.
//

import SwiftUI
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

let MapLocations = [
        MapLocation(name: "St Francis Memorial Hospital", latitude: 37.789467, longitude: -122.416772),
        MapLocation(name: "The Ritz-Carlton, San Francisco", latitude: 37.791965, longitude: -122.406903),
        MapLocation(name: "Honey Honey Cafe & Crepery", latitude: 37.787891, longitude: -122.411223)
        ]


extension CLLocationCoordinate2D {
    static let weequahicPark = CLLocationCoordinate2D(latitude: 40.7063, longitude: -74.1973)
    static let empireStateBuilding = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
    static let columbiaUniversity = CLLocationCoordinate2D(latitude: 40.8075, longitude: -73.9626)
}

//MapAnnotation(
//   coordinate: location.coordinate,
//   content: {
//      Image(systemName: "pin.circle.fill").foregroundColor(.red)
//      Text(location.name)
//   }
//)




struct ServiceDirectoryView: View {
    
    @StateObject var viewModel = ServiceDirectoryViewModel()
    
    @State private var hospitals: [Hospital] = Hospital.getHospitals()
    
    
    var body: some View {
        VStack {
            Map(position: $viewModel.position, selection: $viewModel.selectedResult) {
                
                UserAnnotation()
                
                ForEach(viewModel.searchResults, id: \.self) { result in
                    Marker(item: result)
                }
                .annotationTitles(.hidden)
                
                //Hospitals
                /*
                ForEach(hospitals) { location in
                    Annotation(coordinate: location.coordinate, anchor: UnitPoint(x: 2, y: -2)) {
                        Image(systemName: "building.2.fill")
                            .foregroundStyle(.yellow)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.blue))
                    } label: {
                        VStack {
                            // title
                            Text(location.name)
                                .bold()
                                .foregroundColor(.white)
                                .padding([.top, .horizontal], 5)
                            // subtitle
                            Text(location.name)
                                .foregroundColor(.white)
                                .padding([.bottom, .horizontal], 5)
                        }
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(5)
                    }
                    .annotationTitles(.hidden)
                    .annotationSubtitles(.visible)
                }*/
                
            }
            .mapControls {
                MapCompass()
                    .mapControlVisibility(.visible)
                MapPitchToggle()
                    .mapControlVisibility(.visible)
                MapScaleView()
                    .mapControlVisibility(.hidden)
                MapUserLocationButton()
                    .mapControlVisibility(.visible)
            }
            .mapStyle(.standard(elevation: .realistic))
            //.edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                viewModel.checkIfLocationIsEnabled()
            })
            .onChange(of: viewModel.searchResults) {
                viewModel.position = .automatic
            }
            .onChange(of: viewModel.selectedResult) {
                viewModel.getDirections()
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        viewModel.searchHospital()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                if let selectedResult = viewModel.selectedResult {
                    HStack {
                        Spacer()
                        VStack(spacing:8) {
                            ItemInfoView(selectedResult: selectedResult, route: viewModel.route)
                                .frame(height: 128)
                                .clipShape(RoundedRectangle (cornerRadius: 10))
                                .padding(.horizontal)
                            
                            Button {
                                print("I have been there!")
                                print("Distance: \(viewModel.getDistance()) meters")
                                print("Detail: /n\(String(describing: viewModel.selectedResult))")
                            } label: {
                                Text("I have been there")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .frame(height: 44)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 12)
                        Spacer()
                    }
                    .background(.ultraThinMaterial)
                }
            }
            
        }
        
    }
}

#Preview {
    ServiceDirectoryView()
}
