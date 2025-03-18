//
//  EventDetailsView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 1/15/24.
//

import SwiftUI

struct EventDetailsView: View {
    
    let event: IHelpEvent
    
    var body: some View {
        //        NavigationView {
        
        ScrollView {
            VStack {
                
//                if let image = event.image {
//                    AsyncImage(url: URL(string: image)) { image in
//                        image
//                            .resizable()
//                            .aspectRatio(16/9, contentMode: .fit)
//                            .frame(maxWidth: .infinity)
//                            
//                    } placeholder: {
//                        ProgressView()
//                    }
//                }
                
                Image("alzheimerBanner")
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(event.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                
                Text("Date & Time")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 4.0)
                
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 18))
                        .foregroundColor(Color("primary"))
                                        
                    Text(event.timeWhen)
                        .font(.subheadline)
                    
                    /*Image(systemName: "clock")
                        .font(.system(size: 18))
                        .foregroundColor(Color("primary"))
                    
                    Text("6:00 PM")
                        .font(.subheadline)*/
                    
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("Event Type")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 4.0)
                
                Text(event.eventType)
                    .font(.subheadline)
                    .padding(.horizontal)
                
                
                Text("Location")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 4.0)
                
                HStack(alignment: .top) {
                    Image(systemName: "location")
                        .font(.system(size: 18))
                        .foregroundColor(Color("primary"))
                    
                    Text(event.address)
                        .font(.subheadline)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                
                
                Text("Helpline")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 4.0)
                
                HStack(alignment: .top) {
                    Image(systemName: "phone")
                        .font(.system(size: 18))
                        .foregroundColor(Color("primary"))
                    
                    //Text(event.helpline)
                    Text("+470 854-1487")
                        .font(.subheadline)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("Description")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8.0)
                
                Text(event.description)
                    .font(.body)
                    .padding(.horizontal)
                
                
                Button(action: {
                    // RSVP action
                }) {
                    Text("Register Now")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 46)
                        .background(Color("primary"))
                        .cornerRadius(10)
                }
                .padding(.bottom)
                
                
                
            }
        }
        .navigationBarTitle("Event Details", displayMode: .inline)
        
    }
    
}

//#Preview {
//    EventDetailsView(event: )
//}
