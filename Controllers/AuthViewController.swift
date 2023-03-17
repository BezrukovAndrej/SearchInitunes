import UIKit

class AuthViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iTunes")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "LogIn"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Enter e-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let singUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("SingUP", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let singInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("SingIN", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var textFieldStackView = UIStackView()
    private var buttonsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDelegate()
        setConstreints()
        registerKeyvoardNotification()
        gradientLayer()
    }
    
    deinit {
        removeKeyvoardNotification()
    }
    
// MARK: - Private func
    private func setupView() {
        title = "SingIn"
        
        textFieldStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField],
                                         axis: .vertical,
                                         spacing: 10,
                                         distribution: .fillProportionally)
        
        buttonsStackView = UIStackView(arrangedSubviews: [singInButton, singUpButton],
                                       axis: .horizontal,
                                       spacing: 10,
                                       distribution: .fillEqually)
        
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(textFieldStackView)
        backgroundView.addSubview(buttonsStackView)
        backgroundView.addSubview(logoLabel)

    }
    
    private func setupDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func gradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.bounds
        let backgroundGradient = UIGraphicsImageRenderer(bounds: view.bounds).image { _ in
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        }
        view.backgroundColor = UIColor(patternImage: backgroundGradient)
    }
// MARK: - Action func
    @objc func signUpButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.singUpButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.90)
        }) { (_) in
            UIView.animate(withDuration: 0.1) {
                self.singUpButton.transform = CGAffineTransform.identity
            }
        }
        let singUpViewController = SingUpViewController()
        self.present(singUpViewController, animated: true)
    }
    
    @objc func signInButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.singInButton.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }) { (_) in
            UIView.animate(withDuration: 0.1) {
                self.singInButton.transform = CGAffineTransform.identity
            }
        }
        
        let mail = emailTextField.text ?? ""
        let pasword = passwordTextField.text ?? ""
        let user = findUserDataBase(email: mail)
        
        if user == nil {
            loginLabel.text = "User not found"
            loginLabel.textColor = . red
        } else if user?.password == pasword {
            let navVC = UINavigationController(rootViewController: AlbumsViewController())
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
            
            guard let activUser = user else { return }
            UserDefaultsManager.shared.saveActivUser(user: activUser)
        } else {
            loginLabel.text = "Wrong password"
            loginLabel.textColor = .red
        }
    }
    
    private func findUserDataBase(email: String) -> User? {
        let dataBase = UserDefaultsManager.shared.users
        
        for user in dataBase {
            if user.email == email {
                return user
            }
        }
        return nil
    }
}
// MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
// MARK: - Keyboard function
extension AuthViewController {
    
    private func registerKeyvoardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyvoardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeight = {userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue}().cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}

// MARK: - SetConstreints
extension AuthViewController {
    
    private func setConstreints() {
        
        NSLayoutConstraint.activate([
            logoLabel.bottomAnchor.constraint(equalTo: loginLabel.topAnchor, constant: 130),
            logoLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            logoLabel.heightAnchor.constraint(equalToConstant: 350),
            logoLabel.widthAnchor.constraint(equalToConstant: 450)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textFieldStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textFieldStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textFieldStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 40),
            textFieldStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: textFieldStackView.topAnchor, constant: -30),
        ])
        
        NSLayoutConstraint.activate([
            singUpButton.heightAnchor.constraint(equalToConstant: 40),
            singInButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 40),
            buttonsStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 30),
            buttonsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -40)
        ])
    }
}
