import UIKit

final class SearchViewController: UIViewController, UITextFieldDelegate {

    private let viewModel: SearchViewModel

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chỉ số Valorant"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = Theme.Color.textPrimary
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Nhập Riot ID để xem rank, lịch sử đấu và tiến bộ của bạn."
        label.font = .systemFont(ofSize: 15)
        label.textColor = Theme.Color.textSecondary
        label.numberOfLines = 0
        return label
    }()

    private let riotIDField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "tên#tag",
            attributes: [.foregroundColor: Theme.Color.textSecondary]
        )
        field.font = .systemFont(ofSize: 17)
        field.textColor = Theme.Color.textPrimary
        field.backgroundColor = Theme.Color.surface
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = Theme.Color.border.cgColor
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .search
        field.clearButtonMode = .whileEditing
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        field.leftViewMode = .always
        field.accessibilityLabel = "Riot ID"
        return field
    }()

    private let searchButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Xem chỉ số"
        configuration.baseBackgroundColor = Theme.Color.accent
        configuration.baseForegroundColor = Theme.Color.background
        configuration.cornerStyle = .large
        return UIButton(configuration: configuration)
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Theme.Color.loss
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    init(viewModel: SearchViewModel) {
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
        setUpLayout()

        riotIDField.delegate = self
        searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
    }

    private func setUpLayout() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, riotIDField, searchButton, errorLabel])
        stack.axis = .vertical
        stack.spacing = Theme.Spacing.medium
        stack.setCustomSpacing(Theme.Spacing.small, after: titleLabel)
        stack.setCustomSpacing(Theme.Spacing.large, after: subtitleLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Spacing.large),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.large),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.large),
            riotIDField.heightAnchor.constraint(equalToConstant: 52),
            searchButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    private func render(_ state: SearchViewModel.State) {
        switch state {
        case .idle:
            searchButton.configuration?.showsActivityIndicator = false
            searchButton.isEnabled = true
            errorLabel.isHidden = true
        case .loading:
            searchButton.configuration?.showsActivityIndicator = true
            searchButton.isEnabled = false
            errorLabel.isHidden = true
        case .failed(let message):
            searchButton.configuration?.showsActivityIndicator = false
            searchButton.isEnabled = true
            errorLabel.text = message
            errorLabel.isHidden = false
        }
    }

    @objc private func didTapSearch() {
        view.endEditing(true)
        viewModel.search(text: riotIDField.text ?? "")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSearch()
        return true
    }
}
