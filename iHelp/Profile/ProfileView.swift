//
//  ProfileView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

struct ProfileView: View {
    
    var profileModels = ProfileType.profileModels
    
    @Binding var popToRootTab: Tab
    @State private var isPresentingSurveyFullScreenView = false
    @State var choosenLanguage: Language = LocalizationService.shared.currentLanguage
    //@EnvironmentObject private var appRootManager: RootViewManager
    @EnvironmentObject private var authManager: AuthenticationManager
    
    @State private var navigationPath = NavigationPath()
    
    init(popToRootTab: Binding<Tab>) {
        _popToRootTab = popToRootTab
        
//        let coordinator = Coordinator(self)
//        self._coordinator = StateObject(wrappedValue: coordinator)
    }
    
    mutating func update(for language: Language) {
        
        self.choosenLanguage = language
        
        for indx in 0..<profileModels.count {
            for itmIndx in 0..<profileModels[indx].items.count {
                let localizedTitle = profileModels[indx].items[itmIndx].titleKey.localized()
                profileModels[indx].updateTitle(localizedTitle, item: profileModels[indx].items[itmIndx])
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List{
                ForEach(profileModels) { profileModel in
                    Section(header: Text(profileModel.group)) {
                        ForEach(profileModel.items) { item in
                            
                            if item.type.isNavigationLink {
                                
                                NavigationLink {
                                    switch item.type {
                                    case .profile:
                                        if let user = AuthenticationManager.shared.currentUser {
                                            UserProfileView(user: user)
                                        } else {
                                            EmptyView()
                                        }
                                    case .contactUs:
                                        ContactUsView()
                                    case .aboutUs:
                                        AboutUsView()
                                    case .changePassword:
                                        ChangePasswordView()
                                            .toolbar(.hidden, for: .tabBar)
                                    case .tnc:
                                        PDFUIView(fileName: "tnc")
                                            .ignoresSafeArea()
                                            .navigationTitle("Terms & Conditions")
                                            .navigationBarTitleDisplayMode(.inline)
                                            .toolbar(.hidden, for: .tabBar)
                                    case .privacy:
                                        PDFUIView(fileName: "Privacy-Policy")
                                            .ignoresSafeArea()
                                            .navigationTitle("Terms & Conditions")
                                            .navigationBarTitleDisplayMode(.inline)
                                            .toolbar(.hidden, for: .tabBar)
                                    default:
                                        EmptyView()
                                    }
                                } label: {
                                    
                                    let viewData = ProfileRow.ViewData(
                                        title: item.titleKey.localized(choosenLanguage),
                                        subtitle: item.text,
                                        foregroundColor: item.type == .logout ? .red : Color("primary")
                                    )
                                    
                                    ProfileRow(
                                        profileItem: item,
                                        data: viewData,
                                        pressed: {
                                            switch item.type {
                                            //case .aboutUs:
                                                //let url: NSURL = URL(string: "https://facultyweb.kennesaw.edu/mramos18/index.php")! as NSURL
                                                //UIApplication.shared.open(url as URL)
                                            default:
                                                print(item.type)
                                                break
                                            }
                                        }
                                    )
                                }
                                
                                
                            } else {
                                
                                switch item.type {
                                case .language:
                                    ProfileLanguageRow(
                                        title: item.titleKey) { newLanguage in
                                            print(newLanguage)
                                            //update(for: newLanguage)
                                            self.choosenLanguage = newLanguage
                                        }
                                    
                                default:
                                    
                                    let viewData = ProfileRow.ViewData(
                                        title: item.titleKey.localized(choosenLanguage),
                                        subtitle: item.text,
                                        foregroundColor: item.type == .logout ? .red : Color("primary")
                                    )
                                    
                                    ProfileRow(
                                        profileItem: item,
                                        data: viewData,
                                        pressed: {
                                            switch item.type {
                                            case .survey:
                                                //isPresentingSurveyFullScreenView.toggle()
                                                navigationPath.append("surveys")
                                            case .logout:
                                                //appRootManager.logout()
                                                authManager.logout()
                                                break
                                            default:
                                                break
                                            }
                                        },
                                        showAccessoryView: item.type == .survey
                                    )
                                }
                                
                            }
                            
                        }
                        //End of ForEach
                        
                    }
                }
            }
            .navigationBarTitle(Text("Profile"))
            .navigationViewStyle(StackNavigationViewStyle())
            // Full-screen modal view
            .fullScreenCover(isPresented: $isPresentingSurveyFullScreenView) {
                var survey: Survey = SampleSurvey
                SurveyView(survey: survey, delegate: self.makeCoordinator()).preferredColorScheme(.light)
            }            
            .navigationDestination(for: String.self) { pathValue in
                switch pathValue {
                case "surveys":
                    let surveyViewModel = SurveyViewModel()
                    SurveyListView(navigationPath: $navigationPath, viewModel: surveyViewModel)
                case "tnc":
                    PDFUIView(fileName: "tnc")
                        .ignoresSafeArea()
                        .navigationTitle("Terms & Conditions")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    print("Done tapped!")
                                    navigationPath.removeLast(navigationPath.count)
                                }
                            }
                        }
                        .toolbar(.hidden, for: .tabBar)
                default:
                    EmptyView()

                }
            }
        }
    }
    
    class Coordinator: NSObject, ObservableObject, SurveyViewDelegate {
        
        var parent: ProfileView?
        
        init(_ parent: ProfileView? = nil) {
            self.parent = parent
        }
        
        func surveyCompleted(with survey: Survey) {
            let jsonUrl = URL.documentsDirectory().appendingPathComponent("survey_filled_" + String(Int.random(in: 0...100)) + ".json")
            try? Survey.SaveToFile(survey: survey, url: jsonUrl)
            print( " Saved survey to: \n" , jsonUrl.path )
            parent?.isPresentingSurveyFullScreenView = false
        }
        
        func surveyDeclined() {
            parent?.isPresentingSurveyFullScreenView = false
        }
        
        func surveyRemindMeLater() {
            parent?.isPresentingSurveyFullScreenView = false
        }
    }
}



#Preview {
    let binding: Binding<Tab> = .constant(.home)
    return ProfileView(popToRootTab: binding)
}



struct ProfileLanguageRow: View {
    var title: String
    var onChanged: ((Language) -> Void)?
    
    @AppStorage(LocalizationService.languageOverrideKey)
    var choosenLanguage: Language = LocalizationService.shared.currentLanguage
    
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            Text(title.localized(choosenLanguage))
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color("primary") )
                .padding(.top, 8)
            
            
            Spacer(minLength: 12)
            
            EnumPicker(selected: $choosenLanguage, title: "Choose Language") { enumValue in
                Text(enumValue.name)
            }
            .onChange(of: choosenLanguage, { _, newValue in
                choosenLanguage = newValue
                LocalizationService.shared.setLanguage(newValue)
            })
            .pickerStyle(SegmentedPickerStyle())
            //.padding(.bottom, 8)
            .frame(width: 180)
        }

    }
}


struct ProfileRow: View {
    var profileItem: ProfileItem
    var data: ViewData
    var pressed: (() -> Void)?
    var showAccessoryView: Bool = false
    
    var body: some View {
        Button(action: {
            if (self.pressed == nil) {
                return
            }
            self.pressed!()
        }) {
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(data.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor( data.foregroundColor )
                        .padding(.top, 8)
                    Text(data.subtitle ?? "")
                        .lineLimit(2)
                        .font(.subheadline)
                        .foregroundColor(Color.black)
                }
                if showAccessoryView {
                    Spacer()
                    //NavigationLink.empty
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .font(Font.system(size: 13, weight: .semibold, design: .default))
                        .foregroundColor(Color(red: 0.771, green: 0.771, blue: 0.779))
                }
            }

        }
    }
    
    struct ViewData {
        var id = UUID()
        var title: String
        var subtitle: String?
        var foregroundColor: Color?
    }
}


enum ProfileType: Int, CaseIterable, Codable {
    
    case profile
    case changePassword
    case logout
    
    case language
    case survey
    case tnc
    case privacy
    case faq
    case contactUs
    case aboutUs
    case version
    
    
    var titleKey: String {
        switch self {
        case .profile:
            //"My Profile"
            "profile.row.my.profile"
        case .changePassword:
            //"Change Password"
            "profile.row.change.password"
        case .logout:
            //"Log Out"
            "profile.row.log.out"
            
        case .language:
            //"Choose Language"
            "profile.row.language"
        case .survey:
            //"Submit a Survey"
            "profile.row.submit.survey"
        case .tnc:
            //"Terms & Conditions"
            "profile.row.terms"
        case .privacy:
            //"Privacy Policy"
            "profile.row.privacy"
        case .faq:
            //"FAQ"
            "profile.row.faq"
        case .contactUs:
            //"Contact Us"
            "profile.row.contact.us"
        case .aboutUs:
            //"About Us"
            "profile.row.about.us"
        case .version:
            //"Version"
            "profile.row.version"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .profile:
            nil
        case .changePassword:
            nil
        case .language:
            nil
        case .survey:
            nil
        case .contactUs:
            nil
        case .aboutUs:
            nil
        case .logout:
            nil
        case .version:
            "1.0.0"
        default:
            nil
        }
    }
    
    static var profileModels: [ProfileModel] {
        
        let firstSection: [ProfileType] = [.profile, .changePassword, .logout]
        //[, .changePassword, .contactUs]
        let secondSection: [ProfileType] = [.language, .survey, .tnc, .privacy, .faq, .contactUs, .aboutUs, .version]
        
        let settings = [
            ProfileModel(
                group: "User Profile",
                items: firstSection.map { ProfileItem(titleKey: $0.titleKey, text: $0.subtitle, type: $0) }
            ),
            ProfileModel(
                group: "Others",
                items: secondSection.map { ProfileItem(titleKey: $0.titleKey, text: $0.subtitle, type: $0) }
            )
        ]
        
        return settings
    }
    
    var isNavigationLink: Bool {
        switch self {
        case .language, .survey, .logout, .version:
            false
        default:
            true
        }
    }
    
}

struct ProfileItem: Identifiable {
    var id = UUID()
    var titleKey: String
    var text: String? = ""
    var type: ProfileType
    
    mutating func setTitle(_ title: String) {
        self.titleKey = title
    }
}

struct ProfileModel: Identifiable {
    var id = UUID()
    var group: String
    var items: [ProfileItem]
    
    mutating func updateTitle(_ title: String, item: ProfileItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            //items[index].titleKey = title
            items[index].setTitle(title)
        }
    }
}
