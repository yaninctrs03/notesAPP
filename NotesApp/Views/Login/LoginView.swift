//
//  LoginView.swift
//  NotesApp
//
//  Created by Yanin Contreras on 12/01/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authentication: AuthenticationService
    @FocusState private var focusedField: K.Field?
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("PaperBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 15.0) {
                    Image("NotesApp")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 220.0)
                    Spacer()
                        .frame(height: 50.0)
                    EmailInput(email: $viewModel.email)
                        .focused($focusedField, equals: .email)
                    PasswordInput(password: $viewModel.password)
                        .focused($focusedField, equals: .password)
                    Button {
                        viewModel.makeLogin()
                    } label: {
                        RoundedButton(label: "Log In", active: viewModel.areFieldsValid())
                    }
                    .disabled(!viewModel.areFieldsValid() || viewModel.isLogging)
                    .fullScreenCover(isPresented: $viewModel.isLogged) {
                        MainView()
                    }
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.black)
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                        }.simultaneousGesture(TapGesture().onEnded {
                            viewModel.clearFields()
                        })
                    }
                }
                .padding(.horizontal, 30.0)
                if(viewModel.isLogging){
                    ProgressView()
                }
            }
        }
        .onSubmit {
            switch focusedField {
            case .name:
                focusedField = .email
            case .email:
                focusedField = .password
            case .password:
                if (viewModel.areFieldsValid()){
                    viewModel.makeLogin()
                }
            default: return
            }
        }
        .onAppear {
            self.viewModel.authentication = authentication
        }
        .alert(isPresented: $viewModel.isAlertShown) {
            Alert(title: Text("Login Failed"), message: Text("User Not Found"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationService())
    }
}
