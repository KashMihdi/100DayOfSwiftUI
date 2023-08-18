//
//  Store.swift
//  CupcakeCorner
//
//  Created by Kasharin Mikhail on 16.08.2023.
//

import Foundation
import Combine

public typealias StoreOf<R: ReducerDomain> = Store<R.State, R.Action>

@dynamicMemberLookup
public final class Store<State, Action>: ObservableObject {
    
    private let reducer: any ReducerDomain<State, Action>
    private var cancellable: Set<AnyCancellable> = .init()
    
    @Published public private(set) var state: State
    
    //MARK: - init(_:)
    public init<R: ReducerDomain>(
        state: R.State,
        reducer: R
    ) where R.State == State, R.Action == Action {
        self.state = state
        self.reducer = reducer
    }
    
    //MARK: - Public methods
    public func send(_ action: Action) {
        reducer.reduce(&state, action: action)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &cancellable)
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        state[keyPath: keyPath]
    }
    
}

