//
//  EmergencySupportView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/30/23.
//

import SwiftUI

struct EmergencySupportView: View {
    @State private var userType = "patient"
    @State private var emergencyType = "medical"
    @State private var message = ""
    @State private var location = ""
    @State private var preferredLanguage = "English"
    @State private var contactNumber = ""
    
    var body: some View {
        
        Form {
            Section(header: Text("User Information")) {
                
                Picker("User Type", selection: $userType) {
                    
                    ForEach(UserType.allCases, id: \.self) { userType in
                        Text(userType.title).tag(userType.role_id)
                    }
                    
                    //Text("Patient").tag("patient")
                    //Text("Care Partner").tag("care_partner")
                    //Text("Researcher").tag("researcher")
                }
                
                Picker("Emergency Type", selection: $emergencyType) {
                    Text("Medical Emergencies").tag("medical")
                    Text("Crisis Support").tag("support")
                    Text("General Inquiries").tag("inquiries")
                }.font(.system(size: 14))

                Picker("Preferred Language", selection: $preferredLanguage) {
                    Text("English").tag("English")
                    Text("Filipino").tag("Filipino")
                    // Add more languages as needed
                }
                
                TextField("Location", text: $location)
                
                TextField("Message", text: $message, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
//                        .textFieldStyle(.roundedBorder)

                
                

                
                TextField("Contact Number", text: $contactNumber)
                    .keyboardType(.phonePad)
            }
            
            Section {
                Button(action: {
                    submitEmergencyData()
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.endEditing()})
        
    }
    
    func submitEmergencyData() {
        // Create a dictionary from the entered data
        let emergencyData: [String: Any] = [
            "user_type": userType,
            "emergency_type": emergencyType,
            "message": message,
            "location": location,
            "preferred_language": preferredLanguage,
            "contact_number": contactNumber
        ]
        
        // Convert the dictionary to JSON data (you can use a JSONEncoder)
        if let jsonData = try? JSONSerialization.data(withJSONObject: emergencyData, options: []) {
            // TODO: Submit the JSON data to your server or perform any desired action
            print("Submitted JSON data:")
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        }
    }
    
    // Function to dismiss the keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct EmergencySupportView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencySupportView()
    }
}
