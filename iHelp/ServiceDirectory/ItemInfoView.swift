//
//
//  ItemInfoView.swift
//  MapKitExample
//
//  Created by Laurent B on 21/07/2023.
//

import SwiftUI
import MapKit
import VisionKit

struct ItemInfoView: View {
    // ItemInfoView.swift - Fetch a Look Around scene
    @State private var lookAroundScene: MKLookAroundScene?
    var selectedResult: MKMapItem
    var route: MKRoute?
    
    // Format travel time for display
    private var travelTime: String? {
        guard let route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }
    
    var body: some View {
        
//        VStack(alignment:.center, spacing: 8) {
            LookAroundPreview(initialScene: lookAroundScene)
                .overlay(alignment: .bottomTrailing) {
                    HStack {
                        Text ("\(selectedResult.name ?? "")")
                        if let travelTime {
                            Text(travelTime)
                        }
                    }
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding (10)
                }
                .onAppear {
                    getLookAroundScene()
                }
                .onChange (of: selectedResult) {
                    getLookAroundScene()
                }
//        }

    }
    
    func getLookAroundScene () {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(mapItem: selectedResult)
            lookAroundScene = try? await request.scene
        }
    }


        
    
}

#Preview {
    ItemInfoView(selectedResult: MKMapItem.forCurrentLocation())
}
