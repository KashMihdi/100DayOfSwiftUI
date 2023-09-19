//
//  FullDetailView.swift
//  FriendFace
//
//  Created by Kasharin Mikhail on 18.09.2023.
//

import SwiftUI

struct FullDetailView: View {
    let user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                
                VStack {
                    DetailInformationRow(title: "Age", description: "\(user.age) y.o.")
                    DetailInformationRow(title: "Company", description: user.company)
                    DetailInformationRow(title: "Email", description: user.email)
                    DetailInformationRow(title: "Registration", description: user.registered.formatted(date: .numeric, time: .omitted))
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("About:")
                        .font(.title.bold())
                        .underline()
                    Text(user.about)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Friends:")
                        .font(.title.bold())
                        .underline()
                    
                    ForEach(user.friends.indices, id: \.self) { index in
                        Text("\(index + 1). \(user.friends[index].name)")
                    }
                }
                
                Spacer()
            }
            .padding(.leading)
        .navigationTitle(user.name)
        }
    }
}

struct FullDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FullDetailView(user: User(id: "", isActive: false, name: "Mikle", age: 32, company: "Alum32", email: "alum32@yandex.ru", address: "Brynsk, Burova", about: "The most ordinary person", registered: Date(), tags: [], friends: []))
        }
    }
}
