//
//  TabItem.swift
//  NotesApp
//
//  Created by Yanin Contreras on 17/01/23.
//

import SwiftUI

struct TabItem: View {
    var label: String
    var active: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(tabColor)
                .frame(width: 50.0, height: 130.0)
            Text(label)
                .font(.title3)
                .fontWeight(.semibold)
                .rotationEffect(.degrees(-90))
                .foregroundColor(.text)
        }
    }
    
    var tabColor: Color {
        return active ? .selectedTab : .unselectedTab
    }
}

struct MapTabItem: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.accent)
                .frame(width: 50.0, height: 130.0)
            Text(K.Tabs.map)
                .font(.title3)
                .fontWeight(.semibold)
                .rotationEffect(.degrees(-90))
                .foregroundColor(.text)
        }
    }
}

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                TabItem(label: "Todo", active: true)
                TabItem(label: "Todo", active: false)
            }
        }
    }
}
