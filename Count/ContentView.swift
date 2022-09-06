//
//  ContentView.swift
//  Count
//
//  Created by クワシマ・ユウキ on 2022/09/07.
//

import SwiftUI
import ComposableArchitecture

struct CountState: Equatable {
    var number: Int = 0
}

enum CountAction {
    case add
    case minus
    case multiply2
    case divide2
    case clear
}

struct CountEnvironment {
    
}

struct ContentView: View {
    let countStore: Store<CountState, CountAction> = Store(initialState: CountState(), reducer: Reducer<CountState, CountAction, CountEnvironment>{ state, action, env in
        switch action {
        case .add:
            state.number += 1
        case .minus:
            state.number -= 1
        case .multiply2:
            state.number *= 2
        case .divide2:
            state.number /= 2
        case .clear:
            state.number = 0
        }
        return .none
    }, environment: CountEnvironment())
    var body: some View {
        WithViewStore(self.countStore) { countViewStore in
            VStack {
                Text(String(countViewStore.number))
                    .padding()
                    .font(.title)
                HStack {
                    Button("plus") {
                        countViewStore.send(.add)
                    }.padding()
                    
                    Button("minus") {
                        countViewStore.send(.minus)
                    }.padding()
                }
                HStack {
                    Button("multiply2") {
                        countViewStore.send(.multiply2)
                    }.padding()
                    Button("divide2") {
                        countViewStore.send(.divide2)
                    }.padding()
                }
                Button("clear") {
                    countViewStore.send(.clear)
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
