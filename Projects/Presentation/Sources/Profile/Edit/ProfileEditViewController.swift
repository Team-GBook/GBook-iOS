import UIKit
import Then
import SnapKit
import DesignSystem
import Core
import RxCocoa
import RxSwift


public class ProfileEditViewController: UIViewController{
    
    private let imageData = PublishRelay<Data>()
    private let disposeBag = DisposeBag()
    public let viewModel: ProfileEditViewModel
    public var currentImage: UIImage?
    
    private let headerLabel = UILabel().then {
        $0.text = "프로필 정보 수정"
        $0.font = .systemFont(ofSize: 21, weight: .semibold)
        $0.textColor = .primary50
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 45
        $0.clipsToBounds = true
    }
    private let profileChangeButton = UIButton(type: .system).then {
        let title = "프로필사진변경"
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 12, weight: .medium),
            .foregroundColor: UIColor.black
        ])
        $0.setAttributedTitle(attributedTitle, for: .normal)
    }
    private let imagePicker = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
    }
    public let nameTextField = GBTextField().then {
        $0.placeholder = "이름"
    }
    private let editCompleteButton = GBButton(type: .system).then {
        $0.setTitle("수정 완료", for: .normal)
    }

    public init(viewModel: ProfileEditViewModel) {
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
    private func bind() {
        imagePicker.delegate = self
        profileChangeButton.rx.tap
            .subscribe(onNext: {
                self.present(self.imagePicker, animated: true)
            }).disposed(by: disposeBag)
        profileImageView.image = currentImage
        let input = ProfileEditViewModel.Input(
            editButtonDidTapped: editCompleteButton.rx.tap.asObservable(),
            imageChangeButtonDidTapped: imageData.asObservable(),
            nameText: nameTextField.rx.text.orEmpty.asObservable()
        )
        let _ = viewModel.transform(input: input)
        
    }
    private func addView() {
        [
            headerLabel,
            profileImageView,
            profileChangeButton,
            nameTextField,
            profileChangeButton,
            editCompleteButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(90)
        }
        profileChangeButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(18)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(profileChangeButton.snp.bottom).offset(35)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        editCompleteButton.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
    }
}

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            let imageData = image?.jpegData(compressionQuality: 0.7)
            self.imageData.accept(imageData ?? Data())
            self.profileImageView.image = image
        }
    }
}
