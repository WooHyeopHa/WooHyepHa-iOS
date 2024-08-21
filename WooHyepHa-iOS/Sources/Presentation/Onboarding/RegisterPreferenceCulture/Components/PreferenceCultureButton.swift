import UIKit

class PreferenceCultureButton: UIButton {
    
    private var title: String
    private let buttonTitleLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setButton()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        positionTitleLabel()
    }
}

private extension PreferenceCultureButton {
    func setButton() {
        layer.cornerRadius = 10
        layer.borderWidth = 0
        updateAppearance()
    }
    
    func setupTitleLabel() {
        buttonTitleLabel.text = title
        buttonTitleLabel.textColor = .gray1
        buttonTitleLabel.font = .body2
        buttonTitleLabel.textAlignment = .center
        addSubview(buttonTitleLabel)
    }
    
    func positionTitleLabel() {
        buttonTitleLabel.frame = CGRect(x: 0, y: bounds.height - 35, width: bounds.width, height: 20)
    }
    
    func updateAppearance() {
        if isSelected {
            backgroundColor = .MainColor.withAlphaComponent(0.1)
            layer.borderColor = UIColor.MainColor.cgColor
            layer.borderWidth = 2
            buttonTitleLabel.textColor = .MainColor
        } else {
            backgroundColor = .gray9
            layer.borderColor = UIColor.gray9.cgColor
            layer.borderWidth = 0
            buttonTitleLabel.textColor = .gray1
        }
    }
}
