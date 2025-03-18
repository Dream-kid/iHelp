//
//  ResetPasswordView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 7/10/24.
//

import Foundation
import SwiftUI

struct ResetPasswordView: View {
    
    @Binding var navigationPath: NavigationPath
    @StateObject var viewModel: ResetPasswordViewModel = ResetPasswordViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            
            switch viewModel.state {
            case .idle, .failure:
                // Welcome
                
                VStack(spacing: 20){
                    Text("Reset Your Password".localized())
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 32, fontColor: Color("primary")))
                    
                    Text("Email is sent with OTP to your email Successfully")
                        .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 17, fontColor: Color.primary))
                }
                .padding(.top, 40)
                .padding(.horizontal)
                
                Spacer()
                
                // Form
                VStack(spacing: 15){
                    VStack(alignment: .center, spacing: 30){
                        
                        VStack(alignment: .center) {
                            CustomTextfield(placeholder:
                                                Text("OPT".localized()),
                                            fontName: "RobotoSlab-Light",
                                            fontSize: 17,
                                            fontColor: Color.gray,
                                            username: $viewModel.opt)
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
                    viewModel.resetPassword()
                }){
                    Text("forgetpassword.button.reset".localized())
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 17, fontColor: Color.white))
                        .modifier(LoginButtonStyle(buttonHeight: 52, buttonColor: Color("primary"), buttonRadius: 26))
                }
                .padding(.horizontal,35)
                .padding(.top,30)
                
                Spacer()
                
                
                
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .padding()
                
            case .success:
                Text("Password is reset successfully!")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    navigationPath.removeLast(navigationPath.count)
                }){
                    Text("Go back to SignIn Page".localized())
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 17, fontColor: Color.white))
                        .modifier(LoginButtonStyle(buttonHeight: 52, buttonColor: Color("primary"), buttonRadius: 26))
                }
                .padding(.horizontal,35)
                .padding(.top,30)
            }
            
        }
    }
}


//struct ResetPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResetPasswordView()
//    }
//}

