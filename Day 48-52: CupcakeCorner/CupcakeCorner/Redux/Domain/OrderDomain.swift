//
//  OrderDomain.swift
//  CupcakeCorner
//
//  Created by Kasharin Mikhail on 16.08.2023.
//

import Foundation
import Combine

public struct OrderDomain: ReducerDomain {
    
    public struct State {
        public let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
        public var type: String
        public var quantity: Int
        public var specialRequestEnabled = false
        public var extraFrosting: Bool
        public var addSprinkles: Bool
        
        public var name: String
        public var streetAddress: String
        public var city: String
        public var zip: String
        public var isValidAddress: Bool
        
        public var showAlert: Bool
        public var alertMessage: String
        
        public var order: Order {
            .init(
                type: type,
                quantity: quantity,
                specialRequestEnabled: specialRequestEnabled,
                extraFrosting: extraFrosting,
                addSprinkles: addSprinkles,
                name: name,
                streetAddress: streetAddress,
                city: city,
                zip: zip
            )
        }
        
        public init(
            type: String = "Vanilla",
            quantity: Int = 3,
            specialRequestEnabled: Bool = false,
            extraFrosting: Bool = false,
            addSprinkles: Bool = false,
            name: String = "",
            streetAddress: String = "",
            city: String = "",
            zip: String = "",
            isValidAddress: Bool = false,
            showAlert: Bool = false,
            alertMessage: String = ""
        ) {
            self.type = type
            self.quantity = quantity
            self.specialRequestEnabled = specialRequestEnabled
            self.extraFrosting = extraFrosting
            self.addSprinkles = addSprinkles
            self.name = name
            self.streetAddress = streetAddress
            self.city = city
            self.zip = zip
            self.isValidAddress = isValidAddress
            self.showAlert = showAlert
            self.alertMessage = alertMessage
        }
    }
    
    public enum Action {
        case setCakeType(String)
        case setCakeQuantity(Int)
        case setSpecialRequest(Bool)
        case setExtraFrosting(Bool)
        case addSprinkles(Bool)
        case addName(String)
        case addAddress(String)
        case addCity(String)
        case addZip(String)
        case checkValidAddress
        case post
        case postResponse(Result<Bool, Error>)
        case closeAlert
    }
    
    private let postRequest: (Order) -> AnyPublisher<Bool, Error>
    
    public init(
        postRequest: @escaping (Order) -> AnyPublisher<Bool, Error> = NetworkService.instance.postRequest(order:)
    ) {
        self.postRequest = postRequest
    }
    
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case let .setCakeType(type):
            state.type = type
        case let .setCakeQuantity(quantity):
            state.quantity = quantity
        case let .setSpecialRequest(request):
            state.specialRequestEnabled = request
            if !request {
                state.extraFrosting = false
                state.addSprinkles = false
            }
        case let .setExtraFrosting(frosting):
            state.extraFrosting = frosting
        case let .addSprinkles(sprinkles):
            state.addSprinkles = sprinkles

        case let .addName(name):
            state.name = name
            return Just(.checkValidAddress).eraseToAnyPublisher()
        case let .addAddress(address):
            state.streetAddress = address
            return Just(.checkValidAddress).eraseToAnyPublisher()
        case let .addCity(city):
            state.city = city
            return Just(.checkValidAddress).eraseToAnyPublisher()
        case let .addZip(zip):
            state.zip = zip
            return Just(.checkValidAddress).eraseToAnyPublisher()
        case .checkValidAddress:
            let pattern = "^(?=.*[a-zA-Z0-9])[a-zA-Z0-9 ]{3,20}$"
            state.isValidAddress = [state.name, state.streetAddress, state.city, state.zip].allSatisfy {
                NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: $0)
            }
            
        case .post:
            return postRequest(state.order)
                .map(mapToSuccessResponse(_:))
                .catch(mapToFailResponse(_:))
                .eraseToAnyPublisher()
        case let .postResponse(.success(showAlert)):
            state.showAlert = showAlert
            state.alertMessage = "Your order for \(state.quantity) x \(state.type.lowercased()) cupcakes is on its way!"
        case let .postResponse(.failure(error)):
            print(error.localizedDescription)
            state.showAlert = true
            state.alertMessage = "Oops!"
        case .closeAlert:
            state.showAlert = false
        }
        
        return Empty().eraseToAnyPublisher()
    }
    
    static let previewStore = Store(
        state: Self.State(),
        reducer: Self()
    )
}

private extension OrderDomain {
    func mapToSuccessResponse(_ showAlert: Bool) -> Action {
        .postResponse(.success(showAlert))
    }
    
    func mapToFailResponse(_ error: Error) -> Just<Action> {
        Just(.postResponse(.failure(error)))
    }
}
