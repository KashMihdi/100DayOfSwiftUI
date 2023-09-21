//
//  UserListRow.swift
//  FriendFace
//
//  Created by Kasharin Mikhail on 18.09.2023.
//

import SwiftUI

struct UserListRow: View {
    
    let user: CachedUser
    
    var body: some View {
        NavigationLink(destination: FullDetailView(user: user)) {
            HStack(spacing: 20) {
                Circle()
                    .frame(width: 40)
                    .foregroundColor(user.isActive ? .green : .red)
                VStack(alignment: .leading) {
                    Text(user.wrappedName)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                    + Text(" (\(user.age.formatted()) y.o)")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(user.wrappedEmail)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

//struct UserListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            UserListRow(user: User(id: "", isActive: false, name: "Mikle", age: 32, company: "Alum32", email: "alum32@yandex.ru", address: "Brynsk, Burova", about: "The most ordinary person", registered: Date(), tags: [], friends: []))
//        }
//    }
//}
