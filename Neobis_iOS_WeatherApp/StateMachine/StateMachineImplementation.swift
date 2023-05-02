//
//  StateMachineImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 02.05.2023.
//

import Foundation
//
//class StateMachineImplementation: StateMachine {
//
//    var state: State = .init(context: Context())
//
//    private func emit(status: Status) {
//        self.state.status.accept(status)
//    }
//
//    func handleEvent(event: Event) {
//        switch event {
//        case .startSearch:
//            emit(status: .loading)
//            emit(status: .searching)
//        case .finishSearch(result: .success):
//            emit(status: .loading)
//            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
//                self.emit(status: .showingWeather(with: self.state.context))
//            })
//        case .finishSearch(result: .failure):
//            emit(status: .failure)
//        case .showWeather:
//            emit(status: .loading)
//            emit(status: .showingWeather(with: self.state.context))
//        case .cancelSearch:
//            emit(status: .cancelled)
//        }
//    }
//
//    init(status: Status) {
//        self.state.status.accept(status)
//    }
//
//}
