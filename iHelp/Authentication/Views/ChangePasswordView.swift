//
//  ChangePasswordView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 7/17/24.
//

import Foundation
import SwiftUI

struct ChangePasswordView: View {
    
    //@Binding var navigationPath: NavigationPath
    @StateObject var viewModel: ChangePasswordViewModel = ChangePasswordViewModel()
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
                                                Text("Old Password".localized()),
                                            fontName: "RobotoSlab-Light",
                                            fontSize: 17,
                                            fontColor: Color.gray,
                                            username: $viewModel.oldPassword)
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
                                              password: $viewModel.newPassword)
                            Divider().background(Color.gray)
                        }
                        
                        VStack(alignment: .center) {
                            CustomSecureField(placeholder:
                                                Text("signup.text.confirm.password".localized()),
                                              fontName: "RobotoSlab-Light",
                                              fontSize: 17,
                                              fontColor: Color.gray,
                                              password: $viewModel.confirmNewPassword)
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
                    viewModel.changePassword()
                }){
                    Text("Change Password".localized())
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
                Text("Password is changed successfully!")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    //navigationPath.removeLast(navigationPath.count)
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Go back".localized())
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 17, fontColor: Color.white))
                        .modifier(LoginButtonStyle(buttonHeight: 52, buttonColor: Color("primary"), buttonRadius: 26))
                }
                .padding(.horizontal,35)
                .padding(.top,30)
            }
            
        }
        .navigationBarTitle("Change Password", displayMode: .inline)
    }
}


//struct ResetPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResetPasswordView()
//    }
//}

