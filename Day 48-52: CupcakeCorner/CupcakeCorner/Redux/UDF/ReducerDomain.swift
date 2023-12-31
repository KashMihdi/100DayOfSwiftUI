//
//  ReducerDomain.swift
//  CupcakeCorner
//
//  Created by Kasharin Mikhail on 16.08.2023.
//

import Foundation
import Combine

public protocol ReducerDomain<State, Action> {
    associatedtype State
    associatedtype Action
    
    func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never>
}
