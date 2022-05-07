//
//  ViewController.swift
//  InternetListener
//
//  Created by Andrii Shevchuk on 07.05.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let internetChecker = InternetListener()
    private var anyCancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        internetChecker.pathChecker
            .sink { error in
                print(error)
            } receiveValue: { [weak self] isAvailable in
                guard let self = self else { return }
                self.showConnectionView(with: isAvailable)
            }
            .store(in: &anyCancellables)

    }
    
    private func showConnectionView(with status: Bool) {
        DispatchQueue.main.async {
            let internetConnectionView = InternetStatusView()
            self.setupInternetConnection(connectionView: internetConnectionView, status)
            UIView.animate(withDuration: 0.75, delay: 0.5, options: .layoutSubviews) {
                internetConnectionView.layoutIfNeeded()
            } completion: { result in
                if result {
                    UIView.animate(withDuration: 0.7) {
                        sleep(2)
                        internetConnectionView.removeFromSuperview()
                    }
                }
            }

        }
    }
    
    private func setupInternetConnection(connectionView: InternetStatusView, _ status: Bool) {
        view.addSubview(connectionView)
        
        connectionView.translatesAutoresizingMaskIntoConstraints = false
        connectionView.configure(
            with: status ? "Internet available" : "Internet unavailable",
            color: status ? .green : .red)
        
        NSLayoutConstraint.activate([
            connectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            connectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            connectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            connectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
