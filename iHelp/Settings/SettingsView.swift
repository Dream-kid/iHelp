//
//  ProfileTab.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var popToRootTab: Tab
    
    let settings = SettingsType.settingsModels
    
    init(popToRootTab: Binding<Tab>) {
      _popToRootTab = popToRootTab
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(settings) { setting in
                    Section(header: Text(setting.group)) {
                        ForEach(setting.items) { item in
                            
                            NavigationLink {
                                switch item.type {
                                case .survey:
//                                    var survey: Survey = SampleSurvey
//                                    let jsonUrl = URL.documentsDirectory().appendingPathComponent("sample_survey.json")
//                                    try? Survey.SaveToFile(survey: survey, url: jsonUrl)
//                                    print( " Saved survey to: \n" , jsonUrl.path )
//                                    
//                                    if let loadedSurvey = try? Survey.LoadFromFile(url: jsonUrl) {
//                                        print(" Loaded survey from:\n ", jsonUrl)
//                                        survey = loadedSurvey
//                                    }
//                                    
//                                    SurveyView(survey: survey, delegate: self).preferredColorScheme(.light)
                                    EmptyView()
                                default:
                                    EmptyView()
                                }
                            } label: {
                                SettingsRow(
                                    settings: item,
                                    pressed: {
                                        switch item.type {
                                        case .aboutUs:
                                            let url: NSURL = URL(string: "https://facultyweb.kennesaw.edu/mramos18/index.php")! as NSURL
                                            UIApplication.shared.open(url as URL)
                                        default:
                                            print(item.type)
                                            break
                                        }
                                    }
                                )
                            }
                            

                        }
                        
                    }
                }
            }
            .navigationBarTitle(Text("Settings"))
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}


//extension SettingsView : SurveyViewDelegate {
//    
//    func surveyCompleted(with survey: Survey) {
//        //let jsonUrl = URL.documentsDirectory().appendingPathComponent("survey_filled" + String(Int.random(in: 0...100)) + ".json")
////        let jsonUrl = URL.documentsDirectory().appendingPathComponent("survey_filled.json")
////        try? Survey.SaveToFile(survey: survey, url: jsonUrl)
////        print( " Saved survey to: \n" , jsonUrl.path )
////        
////        ActivityManager.QuestionarySurveryEvent = .submitted
////        openHomeScreen()
//    }
//    
//    func surveyDeclined() {
////        ActivityManager.QuestionarySurveryEvent = .declined
////        openHomeScreen()
//    }
//    
//    func surveyRemindMeLater() {
////        ActivityManager.QuestionarySurveryEvent = .remindLater
////        openHomeScreen()
//    }
//    
//}


struct SettingsRow: View {
    var settings: SettingsItem
    var pressed: (() -> Void)?

    var body: some View {
        Button(action: {
            if (self.pressed == nil) {
                return
            }
            self.pressed!()
        }) {
            VStack(alignment: .leading) {
                
                Text(settings.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor( settings.type == .logout ? .red : Color("primary") )
                    .padding(.top, 8)
                Text(settings.text ?? "")
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
            }
        }
    }
}


enum SettingsType: Int, CaseIterable, Codable {
    
    case survey
    
    case contactUs
    
    case aboutUs
    
    case changePassword
    
    case logout
    
    case version
    
    
    var title: String {
        switch self {
        case .survey:
            return "Submit a Survey"
        case .contactUs:
            return "Contact Us"
        case .aboutUs:
            return "About Us"
        case .changePassword:
            return "Change Password"
        case .logout:
            return "Log Out"
        case .version:
            return "Version"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .survey:
            nil
        case .contactUs:
            nil
        case .aboutUs:
            nil
        case .changePassword:
            nil
        case .logout:
            nil
        case .version:
            "1.0.0"
        }
    }
    
    static var settingsModels: [SettingsModel] {
        
        let primarys: [SettingsType] = [.survey, .changePassword, .contactUs]
        let others: [SettingsType] = [.aboutUs, .version, .logout]

        let settings = [
            SettingsModel(
                group: "Primary",
                items: primarys.map { SettingsItem(title: $0.title, text: $0.subtitle, type: $0) }
            ),
            SettingsModel(
                group: "Others",
                items: others.map { SettingsItem(title: $0.title, text: $0.subtitle, type: $0) }
            )
        ]
                    
        return settings
    }
    
 
}

struct SettingsItem: Identifiable {
    var id = UUID()
    var title: String
    var text: String? = ""
    var type: SettingsType?
}

struct SettingsModel: Identifiable {
    var id = UUID()
    var group: String
    var items: [SettingsItem]
}



