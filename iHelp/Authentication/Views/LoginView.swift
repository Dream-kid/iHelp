//
//  LoginView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/6/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    
    @AppStorage(LocalizationService.languageOverrideKey)
    var choosenLanguage: Language = LocalizationService.shared.currentLanguage
    
    @State private var navigationPath = NavigationPath()
    
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            //ScrollView {
                VStack {
                    
                    switch viewModel.state {
                    case .idle, .failure:
                        
                        //Logo
                        Image("AppLogo")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .padding(.top, 28)
                        
                        // Welcome
                        VStack(spacing: 8){
                            Text("login.text.hello".localized(choosenLanguage))
                                .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 32, fontColor: Color.primary))
                            Text("login.text.enterdetail".localized(choosenLanguage))
                                .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 17, fontColor: Color.primary))
                        }
                        .padding(.top, 8)
                        
                        Spacer()
                        
                        // Form
                        VStack(spacing: 15){
                            VStack(alignment: .center, spacing: 30){
                                VStack(alignment: .center) {
                                    CustomTextfield(placeholder:
                                                        Text("login.text.email".localized(choosenLanguage)),
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
                                                        Text("login.text.password".localized(choosenLanguage)),
                                                      fontName: "RobotoSlab-Light",
                                                      fontSize: 17,
                                                      fontColor: Color.gray,
                                                      password: $viewModel.password)
                                    Divider()
                                        .background(Color.gray)
                                }
                            }
                            HStack{
                                Spacer()
                                Button(action: {
                                    navigationPath.append(AuthenticationViewDestination.forgetPasswordView)
                                }){
                                    Text("login.button.forgot.password".localized(choosenLanguage))
                                        .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 13, fontColor: Color.gray))
                                }
                            }
                        }
                        .padding(.horizontal,35)
                        
                        
                        if case let .failure(error) = viewModel.state {
                            Text(error.localizedDescription)
                                .foregroundColor(.red)
                                .padding()
                        }
                        
                        //Login Button
                        Button(action: {
                            withAnimation(.spring()) {
                                viewModel.login()
                            }
                        }){
                            Text("login.button.login".localized(choosenLanguage))
                                .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 17, fontColor: Color.white))
                                .modifier(LoginButtonStyle(buttonHeight: 52, buttonColor: Color("primary"), buttonRadius: 26))
                        }
                        .padding(.horizontal,35)
                        .padding(.top,30)
                        
                        
                        Spacer()
                        
                        
                        //SignUp
                        HStack{
                            Text("login.text.dont.have.account".localized(choosenLanguage))
                                .modifier(CustomTextM(fontName: "WorkSans-Light", fontSize: 15, fontColor: Color.gray))
                            
                            Button(action: {
                                navigationPath.append(AuthenticationViewDestination.signupView)
                            }){
                                Text("login.button.signup".localized(choosenLanguage))
                                    .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 15, fontColor: Color.primary))
                            }
                        }
                        .padding(.bottom, 20)
                        
                        
                        EnumPicker(selected: $choosenLanguage, title: "Choose Language") { enumValue in
                            Text(enumValue.name)
                        }
                        .onChange(of: choosenLanguage, { _, newValue in
                            choosenLanguage = newValue
                            LocalizationService.shared.setLanguage(newValue)
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                        
                        
                    case .loading:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                            .padding()
                        
                    case .success:
                        Text("Login successful!")
                            .font(.largeTitle)
                            .padding()
                    }
                }
                .navigationDestination(for: AuthenticationViewDestination.self) { destination in
                    switch destination {
                    case .loginView:
                        LoginView()
                    case .signupView:
                        SignupView(navigationPath: $navigationPath)
                    case .forgetPasswordView:
                        ForgetPasswordView(navigationPath: $navigationPath)
                    case .resetPasswordView:
                        ResetPasswordView(navigationPath: $navigationPath)
                    }
                }
            //}
        }
    }
}


struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct CustomTextM: ViewModifier {
    //MARK:- PROPERTIES
    let fontName: String
    let fontSize: CGFloat
    let fontColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .foregroundColor(fontColor)
    }
}

struct LoginButtonStyle: ViewModifier {
    //MARK:- PROPERTIES
    let buttonHeight: CGFloat
    let buttonColor: Color
    let buttonRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: buttonHeight)
            .background(buttonColor)
            .cornerRadius(buttonRadius)
    }
}

