import UIKit
import SnapKit
import Then
import DesignSystem

public class BookDetailViewController: UIViewController {

    private let bookView = BookView()

    private let descriptionTitleLabel = UILabel().then {
        $0.text = "줄거리"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
    }
    private let reviewtitleLabel = UILabel().then {
        $0.text = "줄거리"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }

    private func addView() {
        [
            bookView,
            descriptionTitleLabel,
            descriptionLabel,
            reviewtitleLabel
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {

    }

}
