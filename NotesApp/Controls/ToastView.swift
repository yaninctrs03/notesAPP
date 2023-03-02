//
//  Toast.swift
//  NotesApp
//
//  Created by Yanin Contreras on 23/01/23.
//

import SwiftUI

struct ToastView: View {
    var isShowing: Bool
    var message: String
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(20)
                    .opacity(isShowing ? 1 : 0)
                    .animation(.default, value: true)
            }
            Spacer()
        }
    }
}


struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(isShowing: true, message: "Yes")
    }
}
