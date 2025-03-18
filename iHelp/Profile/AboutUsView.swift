//
//  AboutUsView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 1/17/24.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image("alzheimerBanner")
                    .resizable()
                    .scaledToFit()

                Text("About Us")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("We are a passionate team dedicated to providing the best possible service to our clients. We bring creative, technical, and strategic expertise to every project we undertake.")
                    .font(.body)

//                VStack(alignment: .leading, spacing: 8) {
//                    Text("Contact Us")
//                        .font(.title2)
//                        .fontWeight(.bold)
//
//                    Text("Email: contact@ihelp.com")
//                    Text("Phone: +123 456 7890")
//                    Text("Address: 1100 South Marietta Pkwy SE, Marietta, GA 30060")
//                }

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("About Us", displayMode: .inline)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
