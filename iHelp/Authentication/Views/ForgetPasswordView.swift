//
//  ForgetPasswordView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 7/3/24.
//

import Foundation
import SwiftUI

struct ForgetPasswordView: View {
    
    @Binding var navigationPath: NavigationPath
    
    @StateObject var viewModel: ForgetPasswordViewModel = ForgetPasswordViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            
            switch viewModel.state {
            case .idle, .failure:
                // Welcome
                
                VStack(spacing: 20){
                    Text("Forgot Your Password?".localized())
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 32, fontColor: Color("primary")))
                    Text("Enter your email address below and we'll send you a link to reset your password.")
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
                                                Text("signup.text.email".localized()),
                                            fontName: "RobotoSlab-Light",
                                            fontSize: 17,
                                            fontColor: Color.gray,
                                            username: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            
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
                EmptyView()
            }
        }
        .onReceive(viewModel.$shouldNavigateToResetView) { shouldNavigate in
            if shouldNavigate {
                navigationPath.append(AuthenticationViewDestination.resetPasswordView)
            }
        }
    }
}


//struct ForgetPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgetPasswordView()
//    }
//}

