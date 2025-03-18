//
//  ContactUsView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 1/17/24.
//

import SwiftUI

struct ContactUsView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Get in Touch")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("We'd love to hear from you! Whether you have a question about our services, pricing, or anything else, our team is ready to answer all your questions.")
                    .font(.body)

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Contact Information")
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack {
                        Image(systemName: "envelope")
                        Text("Email: contact@ihelp.com")
                    }

                    HStack {
                        Image(systemName: "phone")
                        Text("Phone: +123 456 7890")
                    }

                    HStack {
                        Image(systemName: "map")
                        Text("Address: 1100 South Marietta Pkwy SE, Marietta, GA 30060")
                    }
                }

                Divider()

                Group {
                    Text("Send Us a Message")
                        .font(.headline)
                    
                    TextField("Your Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Your Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextEditor(text: $message)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )

                    Button(action: sendMessage) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("primary"))
                            .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Contact Us", displayMode: .inline)
    }

    func sendMessage() {
        // Implement message sending logic
        print("Message sent: \(message)")
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
