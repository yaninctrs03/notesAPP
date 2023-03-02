//
//  PlaceholderView.swift
//  NotesApp
//
//  Created by Yanin Contreras on 17/01/23.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .topLeading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder()
                    .opacity(shouldShow ? 1 : 0)
                self
            }
        }
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        withFont font: Font = .body,
        withVerticalSpacing vertical: CGFloat = 0.0,
        withHorizontalSpacing horizontal: CGFloat = 15.0,
        alignment: Alignment = .topLeading) -> some View {
            placeholder(when: shouldShow, alignment: alignment) {
                Text(text)
                    .padding(.horizontal, horizontal)
                    .padding(.vertical, vertical)
                    .foregroundColor(.unselectedTab)
                    .font(font)
            }
        }
}
