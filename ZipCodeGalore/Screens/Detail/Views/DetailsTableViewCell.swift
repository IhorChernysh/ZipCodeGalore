//
//  DetailsTableViewCell.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import UIKit
import SnapKit

class DetailsTableViewCell: UITableViewCell {
    
    private let placeNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Place name:"
        return label
    }()

    private let placeInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "US"
        label.textColor = .lightGray
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "State:"
        return label
    }()

    private let stateInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "NC"
        label.textColor = .lightGray
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    private let longitudeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Longitude:"
        label.textColor = .lightGray
        
        return label
    }()
    
    private let latitudeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "US"
        label.textColor = .lightGray
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    private lazy var placeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeNameLabel, placeInfoLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var stateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stateLabel, stateInfoLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var lonLatStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [longitudeLabel, latitudeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()


    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Methods

    func configure(place: String, state: String, longitude: String, latitude: String) {
        placeInfoLabel.text = place
        stateInfoLabel.text = state
        longitudeLabel.text = "Longitude: \(longitude)"
        latitudeLabel.text = "Latitude: \(latitude)"
    }
}

// MARK: - Setup Layout

extension DetailsTableViewCell {
    private func setupUI() {
        addSubview(placeStackView)
        placeStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(10)
        }
        
        addSubview(stateStackView)
        stateStackView.snp.makeConstraints {
            $0.top.equalTo(placeStackView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        addSubview(lonLatStackView)
        lonLatStackView.snp.makeConstraints {
            $0.top.equalTo(stateStackView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
