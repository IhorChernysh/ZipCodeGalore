//
//  PlaceHeaderDescriptionView.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 12.05.2022.
//

import SnapKit

class PlaceHeaderDescriptionView: UIView {
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "US"
        return label
    }()

    private let zipCodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "22446"
        label.textColor = .black
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryLabel, zipCodeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods

    func configure(country: String, zipCode: String) {
        countryLabel.text = "Country: " + country
        zipCodeLabel.text = "Zip code: " + zipCode
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(10)
        }
    }
}
