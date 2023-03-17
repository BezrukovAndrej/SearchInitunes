import UIKit

class SingUpViewController: UIViewController {
    
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
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Second Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let secondNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let agaTextField: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        textField.backgroundColor = .white
//        textField.textColor = .black
//        textField.attributedPlaceholder = NSAttributedString(string: "Date of birth", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .date
//        datePicker.backgroundColor = .white
//        datePicker.layer.borderColor = UIColor.white.cgColor
//        datePicker.layer.borderWidth = 1
//        datePicker.clipsToBounds = true
//        datePicker.layer.cornerRadius = 6
//        datePicker.tintColor = .gray
//        
//        textField.inputView = datePicker
//        return textField
//    }()
    
    private let ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberTextFild: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let emailValidField: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let singUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        button.setTitle("SingUP", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var elementsStackView = UIStackView()
    private let datePicker = UIDatePicker()
    
    let nameValueType: String.ValidTypes = .name
    let emailValueType: String.ValidTypes = .email
    let passordValueType: String.ValidTypes = .password
    let phoneValueType: String.ValidTypes = .phone
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDataPicker()
        setupDelegate()
        SetConstraints()
        registerKeyvoardNotification()
        gradientLayer()
    }
    
    deinit {
        removeKeyvoardNotification()
    }
    
// MARK: - Private func
    private func setupView() {
        title = "SingUp"
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        
        elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                           firstNameValidLabel,
                                                           secondNameTextField,
                                                           secondNameValidLabel,
                                                           datePicker,
                                                           ageValidLabel,
                                                           phoneNumberTextFild,
                                                           phoneValidLabel,
                                                           emailTextField,
                                                           emailValidField,
                                                           passwordTextField,
                                                           passwordValidLabel],
                                        axis: .vertical,
                                        spacing: 10,
                                        distribution: .fillProportionally)
        
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(singUpButton)
    }
    
    private func gradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.gray.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.bounds
        let backgroundGradient = UIGraphicsImageRenderer(bounds: view.bounds).image { _ in
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        }
        view.backgroundColor = UIColor(patternImage: backgroundGradient)
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        phoneNumberTextFild.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupDataPicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = UIColor.white.cgColor
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .gray
    }
    
    @objc private func singUpButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.singUpButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.90)
        }) { (_) in
            UIView.animate(withDuration: 0.1) {
                self.singUpButton.transform = CGAffineTransform.identity
            }
        }
        
        let firstNameText = firstNameTextField.text ?? ""
        let secondNameText = secondNameTextField.text ?? ""
        let phoneText = phoneNumberTextFild.text ?? ""
        let emailText = emailTextField.text ?? ""
        let passwordText  = passwordTextField.text ?? ""
        
        if firstNameText.isValid(validType: nameValueType)
            && secondNameText.isValid(validType: nameValueType)
            && phoneText.isValid(validType: phoneValueType)
            && emailText.isValid(validType: emailValueType)
            && passwordText.isValid(validType: passordValueType)
            && ageIsValid() == true {
            
            UserDefaultsManager.shared.saveUser(firstName: firstNameText,
                                                secondName: secondNameText,
                                                phone: phoneText,
                                                email: emailText,
                                                password: passwordText,
                                                age: datePicker.date)
            loginLabel.text = "registration complite"
            loginLabel.textColor = .green
        } else {
            loginLabel.text = "Registration"
            alertOk(title: "Error", message: "Enter all fields and your age")
        }
    }
    
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = .green
        } else {
            label.text = wrongMessage
            label.textColor = .red
        }
    }
    
    private func ageIsValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthDay = datePicker.date
        
        let age = calendar.dateComponents([.year], from: birthDay, to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else { return false }
        return (ageUser < 18 ? false : true )
    }
}

// MARK: - UITextFieldDelegate

extension SingUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        switch textField {
        case firstNameTextField: setTextField(textField: firstNameTextField,
                                              label: firstNameValidLabel,
                                              validType: nameValueType,
                                              validMessage: "Name is valid",
                                              wrongMessage: "Only A-Z charactesrs, min 1 characters",
                                              string: string,
                                              range: range)
        case secondNameTextField: setTextField(textField: secondNameTextField,
                                              label: secondNameValidLabel,
                                              validType: nameValueType,
                                              validMessage: "Second Name is valid",
                                              wrongMessage: "Only A-Z charactesrs, min 1 characters",
                                              string: string,
                                              range: range)
        case emailTextField: setTextField(textField: emailTextField,
                                              label: emailValidField,
                                              validType: emailValueType,
                                              validMessage: "Email is valid",
                                              wrongMessage: "Email is not correct, please check",
                                              string: string,
                                              range: range)
        case passwordTextField: setTextField(textField: passwordTextField,
                                              label: passwordValidLabel,
                                              validType: passordValueType,
                                              validMessage: "Password is valid",
                                              wrongMessage: "Password is incorrect, please enter at least 6 characters",
                                              string: string,
                                              range: range)
        case phoneNumberTextFild: setTextField(textField: phoneNumberTextFild,
                                               label: phoneValidLabel,
                                               validType: phoneValueType,
                                               validMessage: "Phone number is valid",
                                               wrongMessage: "Phone number is not correct",
                                               string: string,
                                               range: range)
            
            
        default:
            break
        }
        
        return false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        phoneNumberTextFild.resignFirstResponder()
        return true
    }
}

// MARK: - Keyboard function
extension SingUpViewController {
    
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

// MARK: - Set Constraints

extension SingUpViewController {
    
    private func SetConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
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
            elementsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            elementsStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            singUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            singUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 30),
            singUpButton.heightAnchor.constraint(equalToConstant: 40),
            singUpButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
