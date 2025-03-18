//
//  SignupView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/6/23.
//

import Foundation
import SwiftUI

struct SignupView: View {
    
    @Binding var navigationPath: NavigationPath
    
    @StateObject var viewModel: SignupViewModel = SignupViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            
            switch viewModel.state {
            case .idle, .failure:
                // Welcome
                VStack(spacing: 8){
                    Text("signup.text.register".localized())
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 32, fontColor: Color("primary")))
                    Text("signup.text.create.new.account")
                        .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 17, fontColor: Color.primary))
                }
                .padding(.top, 8)
                
                Spacer()
                
                // Form
                VStack(spacing: 15){
                    VStack(alignment: .center, spacing: 30){
                        VStack(alignment: .center) {
                            CustomTextfield(placeholder:
                                                Text("signup.text.firstName".localized()),
                                            fontName: "RobotoSlab-Light",
                                            fontSize: 17,
                                            fontColor: Color.gray,
                                            username: $viewModel.firstName)
                            Divider()
                                .background(Color.gray)
                        }
                        VStack(alignment: .center) {
                            CustomTextfield(placeholder:
                                                Text("signup.text.lastName".localized()),
                                            fontName: "RobotoSlab-Light",
                                            fontSize: 17,
                                            fontColor: Color.gray,
                                            username: $viewModel.lastName)
                            Divider()
                                .background(Color.gray)
                        }
                        
                        VStack(alignment: .center, spacing: 4) {
                            
                            HStack {
                                Text("User Type".localized())
                                    .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 17, fontColor: Color.gray))
                                Spacer()
                                Picker("User Type", selection: $viewModel.userType) {
                                    ForEach(UserType.allCases) { userType in
                                        Text(userType.title)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                            .padding(.all, 0)
                            
                            Divider()
                                .background(Color.gray)
                        }
                        
                        VStack(alignment: .center) {
                            CustomTextfield(placeholder:
                                                Text("signup.text.email".localized()),
                                            fontName: "RobotoSlab-Light",
                                            fontSize: 17,
                                            fontColor: Color.gray,
                                            username: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            
                            Divider()
                                .background(Color.gray)
                        }
                        VStack(alignment: .center) {
                            CustomSecureField(placeholder:
                                                Text("signup.text.password".localized()),
                                              fontName: "RobotoSlab-Light",
                                              fontSize: 17,
                                              fontColor: Color.gray,
                                              password: $viewModel.password)
                            Divider().background(Color.gray)
                        }
                        VStack(alignment: .center) {
                            CustomSecureField(placeholder:
                                                Text("signup.text.confirm.password".localized()),
                                              fontName: "RobotoSlab-Light",
                                              fontSize: 17,
                                              fontColor: Color.gray,
                                              password: $viewModel.confirmPassword)
                            Divider()
                                .background(Color.gray)
                        }
                    }
                }
                .padding(.horizontal,35)
                
                if case let .failure(error) = viewModel.state {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                }
                
                //Button
                Button(action: {
                    viewModel.signup()
                }){
                    Text("signup.button.signup".localized())
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 17, fontColor: Color.white))
                        .modifier(LoginButtonStyle(buttonHeight: 52, buttonColor: Color("primary"), buttonRadius: 26))
                }
                .padding(.horizontal,35)
                .padding(.top,30)
                
                Spacer()
                
                //SignUp
                HStack{
                    Text("signup.text.have.account".localized())
                        .modifier(CustomTextM(fontName: "WorkSans-Light", fontSize: 15, fontColor: Color.gray))
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("signup.button.signin".localized())
                            .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 15, fontColor: Color.primary))
                    }
                    
                }
                .padding(.bottom, 20)
                
                
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .padding()
                
            case .success:
                Text("Signup successful!")
                    .font(.largeTitle)
                    .padding()
                
            }
            
        }
    }
}

//struct SignupScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        let navigationPath = NavigationPath()
//        SignupView(navigationPath: navigationPath)
//    }
//}
