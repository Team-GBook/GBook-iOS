import UIKit
import SnapKit
import Then

public class CheckBoxButton: UIButton {

    private var genre: Genre?
    private let subjectLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.backgroundColor = .gray
    }
    public init(
        genre: Genre? = nil
    ) {
        super.init(frame: .zero)
        self.genre = genre
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
//        guard let genre = genre else { return }
        if let genre = genre {
            self.subjectLabel.text = genre.rawValue
            print(genre)
        }
        addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
//            $0.top.bottom.equalToSuperview().inset(2)
            $0.leading.equalTo(self.snp.trailing).offset(8)
            $0.height.equalTo(24)
        }

    }
}

public enum Genre: String, CaseIterable {
    case novel = "소설"
    case comic = "만화"
    case fairyTale = "동화"
    case drawing = "그림"
    case selfDevelopment = "자기계발"
    case poetry = "시"
    case biography = "전기"
}
