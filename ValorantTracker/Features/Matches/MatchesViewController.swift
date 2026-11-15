import UIKit

final class MatchesViewController: UIViewController {

    private let viewModel: MatchesViewModel
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let messageLabel = UILabel()

    private lazy var dataSource = UITableViewDiffableDataSource<Int, MatchSummary>(
        tableView: tableView
    ) { tableView, indexPath, match in
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchCell.reuseIdentifier, for: indexPath)
        (cell as? MatchCell)?.configure(with: match)
        return cell
    }

    init(viewModel: MatchesViewModel) {
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
        title = "Trận đấu"
        setUpLayout()

        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
        viewModel.load()
    }

    private func setUpLayout() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MatchCell.self, forCellReuseIdentifier: MatchCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        messageLabel.font = .systemFont(ofSize: 15)
        messageLabel.textColor = Theme.Color.textSecondary
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)

        activityIndicator.color = Theme.Color.textSecondary
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func render(_ state: MatchesViewModel.State) {
        switch state {
        case .loading:
            messageLabel.isHidden = true
            if tableView.refreshControl?.isRefreshing != true {
                activityIndicator.startAnimating()
            }
        case .loaded(let matches):
            activityIndicator.stopAnimating()
            tableView.refreshControl?.endRefreshing()
            apply(matches)
            messageLabel.text = "Chưa có trận nào được lưu cho \(viewModel.riotID.display)."
            messageLabel.isHidden = !matches.isEmpty
        case .failed(let message):
            activityIndicator.stopAnimating()
            tableView.refreshControl?.endRefreshing()
            apply([])
            messageLabel.text = message
            messageLabel.isHidden = false
        }
    }

    private func apply(_ matches: [MatchSummary]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MatchSummary>()
        snapshot.appendSections([0])
        snapshot.appendItems(matches)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    @objc private func didPullToRefresh() {
        viewModel.load()
    }
}
