//
//  InternetListener.swift
//  InternetListener
//
//  Created by Andrii Shevchuk on 07.05.2022.
//
import Combine
import Network
import Foundation

final class InternetListener {
    enum ListenerError: Error {
        case unavailableCheck(String)
    }
    
    lazy var pathChecker: AnyPublisher<Bool, ListenerError> = pathSubject.eraseToAnyPublisher()
    
    private let networkMonitor = NWPathMonitor()
    private let pathSubject = PassthroughSubject<Bool, ListenerError>()
    private let listenerQueue = DispatchQueue(label: "listener-queue")
    
    init() {
        startMonitoring()
    }
    
    deinit {
        networkMonitor.cancel()
    }
    
    private func startMonitoring()  {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            switch path.status {
            case .satisfied:
                self.pathSubject.send(true)
            case .unsatisfied:
                self.pathSubject.send(false)
            default:
                let error = ListenerError.unavailableCheck("Unexpected error")
                self.pathSubject.send(completion: .failure(error))
            }
        }
        
        networkMonitor.start(queue: listenerQueue)
    }
}
