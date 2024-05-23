import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa
import Domain
import Kingfisher

public class BookSearchViewController: UIViewController {
    
    public let viewModel: BookSearchViewModel
    private var disposeBag = DisposeBag()
    private let likeAccept = PublishRelay<String>()
    private let searchTextField = GBTextField().then {
        $0.placeholder = "읽은 책 이름을 검색해주세요"
    }
    private let bookTableView = UITableView().then {
        $0.register(
            BookTableViewCell.self,
            forCellReuseIdentifier: BookTableViewCell.cellIdentifier
        )
        $0.rowHeight = 172
    }
    public init(viewModel: BookSearchViewModel) {
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
        self.navigationController?.navigationBar.isHidden = false
    }
    private func bind() {
        let input = BookSearchViewModel.Input(
            keywordText: searchTextField.rx.text.orEmpty.asObservable(),
            likeAccept: likeAccept.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.searchBooks.asObservable()
            .bind(to: bookTableView.rx.items(
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
//                        print("tap")
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
            searchTextField,
            bookTableView
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(48)
        }
        bookTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

