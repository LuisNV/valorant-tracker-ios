import UIKit

final class MatchCell: UITableViewCell {

    static let reuseIdentifier = "MatchCell"

    private let mapLabel = UILabel()
    private let resultLabel = UILabel()
    private let detailLabel = UILabel()
    private let scoreLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none

        mapLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        mapLabel.textColor = Theme.Color.textPrimary
        resultLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        detailLabel.font = .systemFont(ofSize: 13)
        detailLabel.textColor = Theme.Color.textSecondary
        scoreLabel.font = .monospacedDigitSystemFont(ofSize: 17, weight: .bold)
        scoreLabel.textColor = Theme.Color.textPrimary
        scoreLabel.setContentHuggingPriority(.required, for: .horizontal)

        let titleRow = UIStackView(arrangedSubviews: [mapLabel, resultLabel, UIView()])
        titleRow.spacing = Theme.Spacing.small
        titleRow.alignment = .center

        let textColumn = UIStackView(arrangedSubviews: [titleRow, detailLabel])
        textColumn.axis = .vertical
        textColumn.spacing = 4

        let card = UIStackView(arrangedSubviews: [textColumn, scoreLabel])
        card.spacing = 12
        card.alignment = .center
        card.isLayoutMarginsRelativeArrangement = true
        card.layoutMargins = UIEdgeInsets(top: 12, left: 14, bottom: 12, right: 14)
        card.backgroundColor = Theme.Color.surface
        card.layer.cornerRadius = 14
        card.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(card)

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    func configure(with match: MatchSummary) {
        mapLabel.text = match.map
        resultLabel.text = match.won ? "THẮNG" : "THUA"
        resultLabel.textColor = match.won ? Theme.Color.win : Theme.Color.loss
        detailLabel.text = "\(match.agent) · \(match.kills)/\(match.deaths)/\(match.assists) · \(match.mode)"
        scoreLabel.text = "\(match.roundsWon) – \(match.roundsLost)"
    }
}
