//
//  TextFields.swift
//  NotesApp
//
//  Created by Yanin Contreras on 16/01/23.
//

import SwiftUI

struct NameInput: View {
    @Binding var name: String
    var body: some View {
        ZStack {
            InputBase()
            TextField("", text: $name)
                .textContentType(.name)
                .submitLabel(.next)
                .foregroundColor(.black)
                .autocapitalization(.words)
                .keyboardType(.default)
                .padding(.horizontal)
                .placeholder("Full Name", when: name.isEmpty)
        }
        .padding(.horizontal)
        
    }
}

struct EmailInput: View {
    @Binding var email: String
    var body: some View {
        ZStack {
            InputBase()
            TextField("", text: $email)
                .textContentType(.emailAddress)
                .submitLabel(.next)
                .foregroundColor(.black)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.horizontal)
                .placeholder("Email", when: email.isEmpty)
        }
        .padding(.horizontal)
        
    }
}

struct PasswordInput: View {
    @Binding var password: String
    var body: some View {
        ZStack {
            InputBase()
            SecureField("", text: $password)
            //            {
            //                validate(password)
            //            }
                .tint(.darkGreen)
                .submitLabel(.go)
                .textContentType(.password)
                .foregroundColor(.black)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .keyboardType(.default)
                .padding(.horizontal)
                .placeholder("Password", when: password.isEmpty)
        }
        .padding(.horizontal)
    }
    //
    //    func validate(_ password: String) {
    //
    //    }
}

struct InputBase: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 45.0)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.darkGreen, lineWidth: 2))
    }
}
struct Section: View {
    var label: String
    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.cream)
                .textCase(.uppercase)
                .kerning(2.0)
            Spacer()
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background {
            Color.darkGreen
                .opacity(0.7)
        }
    }
}

struct ProfileItem: View {
    var iconName: String
    @Binding var input: String
    @Binding var isEditing: Bool
    var body: some View {
        HStack(spacing: 15.0) {
            Image(systemName: iconName)
            if isEditing {
                TextField("", text: $input)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.telephoneNumber)
                    .submitLabel(.done)
                    .keyboardType(.numberPad)
                    .placeholder("Edit to add", when: input.isEmpty)
            } else {
                Text(input)
                    .placeholder("Edit to add", when: input.isEmpty)
            }
            
            Spacer()
        }
    }
}
struct TextFields_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NameInput(name: .constant(""))
            EmailInput(email: .constant(""))
            PasswordInput(password: .constant(""))
            Section(label: "Preferences")
            ProfileItem(iconName: "envelope", input: .constant("yan@gmail.com"), isEditing: .constant(true))
        }
        .padding(.horizontal)
    }
}



