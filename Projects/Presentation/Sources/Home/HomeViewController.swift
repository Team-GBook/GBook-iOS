import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa

public class HomeViewController: UIViewController {

    public let viewModel: HomeViewModel
    private let viewWillAppear = PublishRelay<Void>()
    private var disposeBag = DisposeBag()
    private let likeAccept = PublishRelay<String>()
    private let titleLabel = UILabel().then {
        $0.text = "공북"
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.textColor = .primary
    }
    private let searchButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .black
        $0.backgroundColor = .onSurface
    }
    private let profileButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "profile"), for: .normal)
        $0.tintColor = .black
        $0.backgroundColor = .onSurface
    }
    private let bestSellerTitleLabel = UILabel().then {
        $0.text = "베스트셀러"
        $0.font = .systemFont(ofSize: 32, weight: .bold)
    }
    private let bestSellerTableView = UITableView().then {
        $0.register(
            BookTableViewCell.self,
            forCellReuseIdentifier: BookTableViewCell.cellIdentifier
        )
        $0.rowHeight = 172
        $0.isScrollEnabled = false
    }
    private let recommendTitleLabel = UILabel().then {
        $0.text = "추천 도서"
        $0.font = .systemFont(ofSize: 32, weight: .bold)
    }
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
        bind()
    }
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        viewWillAppear.accept(())
    }
    private func bind() {
        let input = HomeViewModel.Input(
            searchButtonDidTapped: searchButton.rx.tap.asObservable(), 
            likeAccept: likeAccept.asObservable(),
            viewWillAppear: viewWillAppear.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.books.asObservable()
            .bind(to: bestSellerTableView.rx.items(
                cellIdentifier: BookTableViewCell.cellIdentifier,
                cellType: BookTableViewCell.self)
            ) { [weak self] row, item, cell in
                guard let self = self else { return }
                cell.bookTitleLabel.text = item.title
                cell.autherLabel.text = item.author
                cell.publisherLabel.text = item.publisher
                cell.bookImageView.kf.setImage(with: URL(string: item.cover))
                cell.isbn = item.isbn
                cell.heartCountLabel.text = "\(item.likeCount)"
                cell.heartButton.rx.tap
                    .subscribe(onNext: { [weak self] in
                        guard let self = self else { return }
                        self.likeAccept.accept(cell.isbn)
                        print("tap")
                        var heartCount = Int(cell.heartCountLabel.text ?? "0")
                        heartCount! += 1
                        cell.heartCountLabel.text = "\(heartCount ?? 0)"

                        let image = UIImage(named: "redHeart")
                        cell.heartButton.setImage(image, for: .normal)
                        cell.heartButton.tintColor = .red

                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
    }
    private func addView() {
        [
            titleLabel,
            profileButton,
            searchButton,
            bestSellerTitleLabel,
            bestSellerTableView
//            recommendTitleLabel
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(33)
        }
        profileButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(titleLabel)
            $0.width.height.equalTo(28)
        }
        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(profileButton.snp.leading).offset(-10)
            $0.width.height.equalTo(28)
        }
        bestSellerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(38)
        }
        bestSellerTableView.snp.makeConstraints {
            $0.top.equalTo(bestSellerTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(344)
        }
//        recommendTitleLabel.snp.makeConstraints {
//            $0.top.equalTo(bestSellerTableView.snp.bottom).offset(10)
//        }
    }
}
