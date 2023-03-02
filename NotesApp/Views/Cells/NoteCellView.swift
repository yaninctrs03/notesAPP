//
//  NoteCellView.swift
//  NotesApp
//
//  Created by Yanin Contreras on 23/01/23.
//

import SwiftUI

struct NoteCellView: View {
    @Binding var note: Note
    var body: some View {
        ZStack(alignment: .topLeading) {
            NavigationLink(destination: NoteDetailView(note: note)) { EmptyView() }.opacity(0.0)
            RoundedRectangle(cornerRadius: 21)
                .foregroundColor(.item)
            VStack(alignment: .leading, spacing: 5.0) {
                HStack {
                    Text(note.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                    Text(note.creationDate, style: .date)
                        .font(.footnote)
                        .foregroundColor(.black)
                }
                Text(note.content)
                    .foregroundColor(.black)
                    .lineLimit(2)
            }
            .padding(.all)
        }
        .frame(height: 110.0)
    }
}

struct NoteCellView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCellView(note: .constant(Note(id: nil, userId: "", title: "Today Note", content: "this is a new note because it is just for testing the size and content of my view text", latitude: 0.0, longitude: 0.0, creationDate: nil, category: 0)))
    }
}
