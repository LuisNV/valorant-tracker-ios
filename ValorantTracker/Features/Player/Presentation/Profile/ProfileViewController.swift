import UIKit

final class ProfileViewController: UIViewController {

    var onShowMatches: (() -> Void)?

    private let viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Color.background
        title = "Hồ sơ"

        let nameLabel = UILabel()
        nameLabel.text = viewModel.title
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        nameLabel.textColor = Theme.Color.textPrimary

        let detailLabel = UILabel()
        detailLabel.text = "\(viewModel.levelText) · \(viewModel.regionText)"
        detailLabel.font = .systemFont(ofSize: 15)
        detailLabel.textColor = Theme.Color.textSecondary

        let card = UIStackView(arrangedSubviews: [nameLabel, detailLabel])
        card.axis = .vertical
        card.spacing = 4
        card.isLayoutMarginsRelativeArrangement = true
        card.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        card.backgroundColor = Theme.Color.surface
        card.layer.cornerRadius = 16

        // TODO: rank card, stat tiles, RR chart and top agents once the backend has /stats.

        var configuration = UIButton.Configuration.filled()
        configuration.title = "Xem trận đấu"
        configuration.baseBackgroundColor = Theme.Color.accent
        configuration.baseForegroundColor = Theme.Color.background
        configuration.cornerStyle = .large
        let matchesButton = UIButton(configuration: configuration)
        matchesButton.addTarget(self, action: #selector(didTapMatches), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [card, matchesButton])
        stack.axis = .vertical
        stack.spacing = Theme.Spacing.medium
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Spacing.medium),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            matchesButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func didTapMatches() {
        onShowMatches?()
    }
}
