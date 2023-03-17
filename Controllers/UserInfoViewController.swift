import UIKit

class UserInfoViewController: UIViewController {
    
    private let userLogo: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "userLogo")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.ypWhite.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Fist Name:"
        label.textColor = .ypWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Second Name:"
        label.textColor = .ypWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let labal = UILabel()
        labal.text = "Age:"
        labal.textColor = .ypWhite
        labal.translatesAutoresizingMaskIntoConstraints = false
        return labal
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone:"
        label.textColor = .ypWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail:"
        label.textColor = .ypWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView = UIStackView()
    var stackView2 = UIStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setModel()
    }
    
// MARK: - Private func
    private func setupViews() {
        view.backgroundColor = .ypBlack
        title = "Active User"
        navigationController?.navigationBar.tintColor = .ypWhite
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ypWhite]
        
        stackView = UIStackView(arrangedSubviews: [firstNameLabel,
                                                   secondNameLabel,
                                                   ],
                                axis: .vertical,
                                spacing: 30,
                                distribution: .fillProportionally)
        
        stackView2 = UIStackView(arrangedSubviews: [ageLabel,
                                                   phoneLabel,
                                                   emailLabel],
                                 axis: .vertical,
                                 spacing: 20,
                                 distribution: .fillProportionally)
        
        
        view.addSubview(stackView)
        view.addSubview(stackView2)
        view.addSubview(userLogo)
    }
    
    private func setModel() {
        guard let activUser = UserDefaultsManager.shared.activUser else { return }
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormater.string(from: activUser.age)
        
        firstNameLabel.text = "First Name: \(activUser.firstName)"
        secondNameLabel.text = "Second Name: \(activUser.secondName)"
        emailLabel.text = "E-mail: \(activUser.email)"
        phoneLabel.text = "Phone: \(activUser.phone)"
        ageLabel.text = "Age: \(dateString)"
    }
}

// MARK: - Set Constraints
extension UserInfoViewController {
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            userLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            userLogo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            userLogo.widthAnchor.constraint(equalToConstant: 100),
            userLogo.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: userLogo.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            stackView2.topAnchor.constraint(equalTo: userLogo.bottomAnchor, constant: 15),
            stackView2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 15)
        ])
    }
}
