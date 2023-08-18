//
//  NetworkService.swift
//  CupcakeCorner
//
//  Created by Kasharin Mikhail on 18.08.2023.
//

import SwiftUI
import Combine

public struct NetworkService {
    public static let instance = NetworkService()
    private var cancellables: Set<AnyCancellable> = []
    
    private init() {}
    
    public func postRequest(order: Order) -> AnyPublisher<Bool, Error> {
        Just(order)
            .encode(encoder: JSONEncoder())
            .flatMap { encodedOrder -> AnyPublisher<Bool, Error> in
                let url = URL(string: "https://reqres.in/api/cupcakes")!
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                request.httpBody = encodedOrder
                return URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { data, response -> Bool in
                        guard let httpResponse = response as? HTTPURLResponse else {
                            throw URLError(.badServerResponse)
                        }
                        if (200...299).contains(httpResponse.statusCode) {
                            return true
                        } else {
                            throw URLError(.badServerResponse)
                        }
                    }
                    .mapError { $0 }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

