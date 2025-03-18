//
//  SurveyCardView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 3/20/24.
//

import SwiftUI

struct SurveyCardView: View {
    
    let cardData: SurveyCardData
    var buttonAction: () -> Void
    
    var body: some View {
//        ZStack {
            
            VStack(alignment: .leading) {
                
                Text(cardData.title)
                    .foregroundColor(Color("flag-blue"))
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 4.0)
                
                Text(cardData.subtitle)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                                
                // Button
                Button(action: {
                    // Define your action here
                    self.buttonAction()
                }) {
                    Text(cardData.actionText)
                        .foregroundColor(.white)
                        .font(.subheadline)
//                        .fontWeight(.semibold)
                        .padding(8.0)
                        .background(Color("primary"))
                        .cornerRadius(8)
                        
                        .fixedSize(horizontal: false, vertical: true)
                }.padding(.top, 6)
                
            }
            .frame(maxWidth: .infinity, minHeight: 100.0) // Adjust height as needed
            .padding(16.0)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color("card-bg")))
//        }
//        .padding(.horizontal, 10) // Reduces card width slightly for left and right padding
    }
    
    
    struct SurveyCardData {
        let title: String
        let subtitle: String
        let actionText: String
    }
}
