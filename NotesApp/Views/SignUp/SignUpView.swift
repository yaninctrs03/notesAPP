//
//  SignUpView.swift
//  NotesApp
//
//  Created by Yanin Contreras on 17/01/23.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authentication: AuthenticationService
    @FocusState private var focusedField: K.Field?
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Image("PaperBackground")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("NotesApp")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 220.0)
                Spacer()
                    .frame(height: 50.0)
                NameInput(name: $viewModel.fullName)
                    .focused($focusedField, equals: .name)
                EmailInput(email: $viewModel.email)
                    .focused($focusedField, equals: .email)
                PasswordInput(password: $viewModel.password)
                    .focused($focusedField, equals: .password)
                Button {
                    viewModel.validateUser()
                } label: {
                    RoundedButton(label: "Create Account", active: viewModel.areFieldsValid())
                }.disabled(!viewModel.areFieldsValid())
            }
            .padding(.horizontal)
            if(viewModel.isLoading){
                ProgressView()
            }
        }
        .onSubmit {
            switch focusedField {
            case .name:
                focusedField = .email
            case .email:
                focusedField = .password
            case .password:
                viewModel.validateUser()
            default: return
            }
        }
        .onAppear {
            self.viewModel.authentication = authentication
        }
        .alert(isPresented: $viewModel.isAlertShown) {
            Alert(title: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
