import UIKit
import SnapKit
import Then
import DesignSystem

public class BookReviewWriteViewContler: UIViewController {

    private let scrollView = UIScrollView()
    private let backgroundView = UIView()
    private let bookView = BookView().then {
        $0.backgroundColor = .white
    }
    private let translateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.text = "해석"
    }
    private let translateTextView = GBTextView()
    private let reconstructionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.text = "재구성"
    }
    private let reconstructionTextView = GBTextView()
    private let reviewLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.text = "감상평"
    }
    private let reviewTextView = GBTextView()
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
    }
    
}

extension BookReviewWriteViewContler {
    private func addView() {
//        view.addSubview(backgroundView)
//        backgroundView.addSubview(scrollView)
        [
            bookView,
            translateLabel,
            translateTextView,
            reconstructionLabel,
            reconstructionTextView
            
        ].forEach { view.addSubview($0) }
        
    }
    private func setLayout() {
        bookView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(173)
        }
        translateLabel.snp.makeConstraints {
            $0.top.equalTo(bookView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(24)
        }
        translateTextView.snp.makeConstraints {
            $0.top.equalTo(translateLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(150)
        }
        reconstructionLabel.snp.makeConstraints {
            $0.top.equalTo(translateTextView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(24)
        }
        reconstructionTextView.snp.makeConstraints {
            $0.top.equalTo(reconstructionLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(150)
        }
    }
}
