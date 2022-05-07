import Foundation
import UIKit

final class InternetStatusView: UIView {
    private lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.cornerRadius = 1.0
        backgroundView.layer.borderColor = UIColor.blue.cgColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont(name: "AmericanTypewriter-CondensedBold", size: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupBackgroundView()
        setupTitleView()
    }
    
    private func setupBackgroundView() {
        addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    private func setupTitleView() {
        backgroundView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with title: String, color: UIColor) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
            self.backgroundView.backgroundColor = color
        }
    }
}
