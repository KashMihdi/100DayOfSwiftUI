//
//  UserViewModel.swift
//  FriendFace
//
//  Created by Kasharin Mikhail on 18.09.2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [CachedUser] = .init()
    let storageManager: StorageManager = .shared
    
    init() {
        getData()
    }
    
    func getData() {
        storageManager.fetchData { result in
            switch result {
            case let .success(data):
                self.users = data
                if users.isEmpty {
                    print("Loading")
                    getUsers()
                }
                print("Read CoreData")
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getUsers() {
        Task {
            do {
                try await fetchUsers()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor func fetchUsers() async throws {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Bad URL")
            throw URLError(.badURL) }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            print("Badly request")
            throw URLError(.dataNotAllowed)
        }
        
        guard let badResponse = response as? HTTPURLResponse,
              (200...299).contains(badResponse.statusCode) else {
            print("Bad URL Response")
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let users = try? decoder.decode([User].self, from: data) else {
            print("Can't decode data")
            throw URLError(.cannotDecodeRawData)
        }
        storageManager.create(users)
        storageManager.fetchData { result in
            switch result {
            case let .success(data): self.users = data
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
}

