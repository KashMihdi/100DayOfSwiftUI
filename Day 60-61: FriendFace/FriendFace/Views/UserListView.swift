//
//  UserListView.swift
//  FriendFace
//
//  Created by Kasharin Mikhail on 18.09.2023.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var vm = UserViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.users, content: UserListRow.init)
            }
            .scrollIndicators(.hidden)
            .listStyle(.inset)
            .navigationTitle("User List")
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
