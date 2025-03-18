//
//  EventListView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 1/15/24.
//

import SwiftUI

struct EventListView: View {
    
    @ObservedObject var viewModel: EventViewModel
    
    //    let events: [GoogleEvent] = GoogleEventResults.GetEvents()
    
    var body: some View {
        
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .onAppear {
                    viewModel.needsUpdate = true
                }
        case .success:
//            NavigationView {
                
                List {
                    Section(header: Text("IHelp Events")) {
                        ForEach(viewModel.events) { event in
                            NavigationLink {
                                EventDetailsView(event: event)
                            } label: {
                                EventRow(event: event)
                            }
                        }
                    }
                    
                    
                    Section(header: Text("Online Events"), footer: footerView()) {
                        EmptyView() // Empty view for demonstration
                    }
                }
                .navigationTitle("Events & Activities")
//            }
            
        case .failure(let error):
            Text("Failed to load data: \(error.localizedDescription)")
        }
        
    }
    
    // Footer view with a Button to trigger navigation
    func footerView() -> some View {
        
        NavigationLink {
            WebView(sourceType: .url(URL(string: "https://www.dementiamap.com/events/#!calendar")!))
                .ignoresSafeArea()
                .navigationTitle("Online Events")
                .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Click Here for More Online Events")
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("primary"))
                .foregroundColor(Color.white)
                .cornerRadius(10)
        }
    }
}



struct EventRow: View {
    let event: IHelpEvent
    
    var body: some View {
        
        HStack {
            
            Text(event.startDateString)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.headline)
                Text(event.timeWhen)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(event.address)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(1, contentMode: .fill)
                .clipped()
                .cornerRadius(3.0)
            
            /*AsyncImage(url: URL(string: event.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .aspectRatio(1, contentMode: .fill)
                    .clipped()
                    .cornerRadius(3.0)
                
            } placeholder: {
                ProgressView()
            }*/
            
            //            AsyncImageView(url: )
        }
    }
    
    
}


#Preview {
    EventListView(viewModel: EventViewModel())
}
