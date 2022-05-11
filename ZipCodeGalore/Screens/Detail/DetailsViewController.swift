//
//  DetailsViewController.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - UI Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.description())

        return tableView
    }()
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.backgroundColor = UIColor(red: 47/255, green: 165/255, blue: 201/255, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
        
    // MARK: - Properties
    
    private var viewModel: DetailsViewModel!
    
    // MARK: - Init
    
    init(viewModel: DetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCurrentVC()
    }
    
    // MARK: - Handlers
    
    @objc private func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - Methods

    private func setupCurrentVC() {
        setupUI()
        setupBinding()
    }
    
    private func setupBinding() {
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Zip code info"

        closeButton.addTarget(self, action: #selector(closeButtonPressed(_:)), for: .touchUpInside)
        
        addCloseButton()
        addTableView()
    }
    
    private func addCloseButton() {
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(34)
            $0.width.equalTo(64)
        }
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(closeButton.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = PlaceHeaderDescriptionView()
        headerView.configure(country: viewModel.selectedInfo?.country ?? "",
                             zipCode: viewModel.selectedInfo?.postCode ?? "")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.description(), for: indexPath) as? DetailsTableViewCell else {
            return UITableViewCell()
        }
        if let itemToSet = viewModel.itemByIndexPath(indexPath) {
            cell.configure(place: itemToSet.placeName,
                           state: itemToSet.state,
                           longitude: itemToSet.longitude,
                           latitude: itemToSet.latitude)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
