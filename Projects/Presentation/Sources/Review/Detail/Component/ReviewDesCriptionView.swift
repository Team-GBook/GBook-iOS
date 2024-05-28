import UIKit
import DesignSystem
import SnapKit
import Then
import Domain
import Core

class ReviewDesCriptionView: BaseView<ReviewDetailEntity> {

    private let reviewTItleLabel = UILabel().then {
        $0.text = "해석"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let reviewLabel = UILabel().then {
        $0.text = "‘희완’이와 ‘람우’는 서로 좋아했지만 각자의 사정으로 인해 좋아한다는 말 한마디를 쉽게 전하지 못하고, 열일곱 살에 사고로 헤어지게 된다. 저승사자가 되어 돌아온 람우는 어차피 일주일 뒤 죽을 거 괴롭게 죽느니 편하게 가라고 입으로 종용하는 한편, 괴상한 버킷리스트를 만들어 희완이를 억지로 끌고 다닌다. 두 사람이 버킷리스트의 일들을 하나씩 하나씩 실천해 가는 동안에도 ‘좋아한다’라는 말은 둘의 입 밖으로 나오지 않고 입안에서 맴돌기만 한다. 그리고 일주일의 마지막 날, 희완이에게 가장 행복한 시간을 선물했던 람우의 입에서 흘러나온 말은 좋아한다는 고백이 아닌 차갑고 냉정한 이야기였는데……."
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    private let reviewLineView = BottomLineView()
    private lazy var reviewStackView = UIStackView(arrangedSubviews: [
        reviewTItleLabel,
        reviewLabel,
        reviewLineView
    ]).then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    private let reconstructionTitleLabel = UILabel().then {
        $0.text = "재구성"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let reconstructionLabel = UILabel().then {
        $0.text = "‘희완’이와 ‘람우’는 서로 좋아했지만 각자의 사정으로 인해 좋아한다는 말 한마디를 쉽게 전하지 못하고, 열일곱 살에 사고로 헤어지게 된다. 저승사자가 되어 돌아온 람우는 어차피 일주일 뒤 죽을 거 괴롭게 죽느니 편하게 가라고 입으로 종용하는 한편, 괴상한 버킷리스트를 만들어 희완이를 억지로 끌고 다닌다. 두 사람이 버킷리스트의 일들을 하나씩 하나씩 실천해 가는 동안에도 ‘좋아한다’라는 말은 둘의 입 밖으로 나오지 않고 입안에서 맴돌기만 한다. 그리고 일주일의 마지막 날, 희완이에게 가장 행복한 시간을 선물했던 람우의 입에서 흘러나온 말은 좋아한다는 고백이 아닌 차갑고 냉정한 이야기였는데……."
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    private let reconstructionBottomLineView = BottomLineView()
    private lazy var reconstructionStackView = UIStackView(arrangedSubviews: [
        reconstructionTitleLabel,
        reconstructionLabel,
        reconstructionBottomLineView
    ]).then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    private let analysisTitleLabel = UILabel().then {
        $0.text = "감상평"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let analysisLabel = UILabel().then {
        $0.text = "‘희완’이와 ‘람우’는 서로 좋아했지만 각자의 사정으로 인해 좋아한다는 말 한마디를 쉽게 전하지 못하고, 열일곱 살에 사고로 헤어지게 된다. 저승사자가 되어 돌아온 람우는 어차피 일주일 뒤 죽을 거 괴롭게 죽느니 편하게 가라고 입으로 종용하는 한편, 괴상한 버킷리스트를 만들어 희완이를 억지로 끌고 다닌다. 두 사람이 버킷리스트의 일들을 하나씩 하나씩 실천해 가는 동안에도 ‘좋아한다’라는 말은 둘의 입 밖으로 나오지 않고 입안에서 맴돌기만 한다. 그리고 일주일의 마지막 날, 희완이에게 가장 행복한 시간을 선물했던 람우의 입에서 흘러나온 말은 좋아한다는 고백이 아닌 차갑고 냉정한 이야기였는데……."
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    private let analysisBottomLineView = BottomLineView()
    override func configure(with item: ReviewDetailEntity) {
        self.reviewLabel.text = item.review
        self.reconstructionLabel.text = item.reconstruction
        self.analysisLabel.text = item.analysis
    }
    private lazy var analysisStackView = UIStackView(arrangedSubviews: [
        analysisTitleLabel,
        analysisLabel,
        analysisBottomLineView
    ]).then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    override func addView() {
        [
            reviewStackView,
            reconstructionStackView,
            analysisStackView
        ].forEach { addSubview($0) }
    }
    override func setLayout() {
        reviewStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        reconstructionStackView.snp.makeConstraints {
            $0.top.equalTo(reviewStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        analysisStackView.snp.makeConstraints {
            $0.top.equalTo(reconstructionStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
