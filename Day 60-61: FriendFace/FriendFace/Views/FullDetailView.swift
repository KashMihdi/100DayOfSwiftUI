//
//  FullDetailView.swift
//  FriendFace
//
//  Created by Kasharin Mikhail on 18.09.2023.
//

import SwiftUI

struct FullDetailView: View {
    let user: CachedUser
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                
                VStack {
                    DetailInformationRow(title: "Age", description: "\(user.age) y.o.")
                    DetailInformationRow(title: "Company", description: user.wrappedCompany)
                    DetailInformationRow(title: "Email", description: user.wrappedEmail)
                    DetailInformationRow(title: "Registration", description: user.wrappedRegistered.formatted(date: .numeric, time: .omitted))
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("About:")
                        .font(.title.bold())
                        .underline()
                    Text(user.wrappedAbout)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Friends:")
                        .font(.title.bold())
                        .underline()
                    
                    ForEach(user.candyArray) {
                        Text($0.wrappedName)
                    }
                }
                
                Spacer()
            }
            .padding(.leading)
            .navigationTitle(user.wrappedName)
        }
    }
}

//struct FullDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            FullDetailView(user: User(id: "", isActive: false, name: "Mikle", age: 32, company: "Alum32", email: "alum32@yandex.ru", address: "Brynsk, Burova", about: "The most ordinary person", registered: Date(), tags: [], friends: []))
//        }
//    }
//}
