//
//  HomeViewController.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import SnapKit
import JGProgressHUD

class HomeViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        //tableView.separatorColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.register(HomeZipTableViewCell.self, forCellReuseIdentifier: HomeZipTableViewCell.description())

        return tableView
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.textColor = .black
        textField.textAlignment = .center
        textField.delegate = self
        textField.placeholder = "Enter Zip Code"
        return textField
    }()
    
    private var findButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find Information", for: .normal)
        button.backgroundColor = UIColor(red: 47/255, green: 165/255, blue: 201/255, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let progressHud = JGProgressHUD(style: .dark)
    
    // MARK: - Properties
    
    private var homeViewModel: HomeViewModel!
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.homeViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupCurrentVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Handlers
    
    @objc private func findInfoPressed(_ sender: UIButton) {
        guard let enteredCode = searchTextField.text,
        !enteredCode.isEmpty else {
            let alert = self.createAlert(message: "Please, enter valid zip code", style: .alert)
            self.present(alert, animated: true)
            return
        }
        
        self.view.addSpinner(progressHud: self.progressHud)
        homeViewModel.fetchInfoByCode(enteredCode: enteredCode) { [weak self] placeInfo, errorDescr in
            guard let self = self else { return }
            self.view.removeSpinner(progressHud: self.progressHud)

            if let errorInfo = errorDescr {
                let alert = self.createAlert(message: errorInfo, style: .alert)
                self.present(alert, animated: true)
                return
            }
            
            self.homeViewModel.successfullyLoadedInfo(placeInfo: placeInfo)
        }
    }
    
    // MARK: - Methods

    private func setupCurrentVC() {
        setupUI()
        setupBinding()
    }
    
    private func setupBinding() {
        self.homeViewModel.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Find by your Zip"

        findButton.addTarget(self, action: #selector(findInfoPressed(_:)), for: .touchUpInside)
        
        addTextFieldAndButton()
        addTableView()
    }
    
    private func addTextFieldAndButton() {
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        view.addSubview(findButton)
        findButton.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(findButton.snp.bottom).offset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeZipTableViewCell.description(), for: indexPath) as? HomeZipTableViewCell else {
            return UITableViewCell()
        }
        let itemToSet = homeViewModel.itemByIndexPath(indexPath)
        cell.configure(code: itemToSet.postCode)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        homeViewModel.didSelectByIndexPath(indexPath)
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
}

// MARK: - HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func didSelectPlace(_ place: PlaceInfo) {
        let viewModel = DetailsViewModel(placeInfo: place)
        let vc = DetailsViewController(viewModel: viewModel)
        navigationController?.present(vc, animated: true)
    }
    
    func newInfoLoaded(_ place: PlaceInfo) {
        let lastIndexPath = homeViewModel.findLastItemIndexPath()
        tableView.reloadData()
        
        homeViewModel.didSelectByIndexPath(lastIndexPath)
    }
}
