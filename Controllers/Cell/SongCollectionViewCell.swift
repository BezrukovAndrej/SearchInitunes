import UIKit

class SongsCollectionViewCell: UICollectionViewCell {
    
    let nameSongLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.addSubview(nameSongLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - SetConstreints
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            nameSongLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameSongLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameSongLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameSongLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            
        ])
    }
}
