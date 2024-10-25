//
//  CharactersListViewController.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import UIKit

class CharactersListViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    
    static var identifier: String { String(describing: self) }
        
    var nextPageLoadingSpinner: UIActivityIndicatorView?
    var fullPageLoadingSpinner: UIActivityIndicatorView?

    var viewModel: CharactersListViewModel!
    private lazy var charactersUseCase: CharactersUseCase = {
        let charactersRepository: CharactersRepository = DefaultCharactersRepositoryImplementer()
        return DefaultCharactersUseCase(charactersRepository: charactersRepository)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        setupUI()
        bindViewModel()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        loadData()
    }
    
    //MARK: - Private Methods
    private func loadData() {
        self.viewModel.update()
    }
    
    private func bindViewModel() {
        self.viewModel = CharactersListViewModel(charactersUseCase: charactersUseCase)
         
        self.viewModel.charactersCompletionHandler = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.viewModel.loadingCompletionHandler = { [weak self] in
            guard let self = self else {
                return
            }
             
            self.updateLoading($0)
        }
        
        self.viewModel.error = { errorMsg in
            self.showAlert(with: errorMsg)
        }
    }
     
    private func updateLoading(_ loading: CharactersListViewModelLoading) {
        DispatchQueue.main.async {
            switch loading {
                case .fullScreen: self.handleFullPageLoading(isAnimating: true)
                case .nextPage, .none: self.handleFullPageLoading(isAnimating: false)
            }
            
            self.updateTableViewFooterLoading(loading)
        }
    }
    
    private func handleFullPageLoading(isAnimating: Bool) {
        if isAnimating {
            fullPageLoadingSpinner?.removeFromSuperview()
            fullPageLoadingSpinner = self.makeActivityIndicator(size: .init(width: self.view.frame.width, height: 44))
            self.view.addSubview(fullPageLoadingSpinner!)
            fullPageLoadingSpinner?.center = self.view.center
            fullPageLoadingSpinner?.startAnimating()
        } else {
            fullPageLoadingSpinner?.removeFromSuperview()
        }
    }
    
    func updateTableViewFooterLoading(_ loading: CharactersListViewModelLoading) {
        switch loading {
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = tableView.makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
            tableView.tableFooterView = nextPageLoadingSpinner
            case .fullScreen, .none:
                tableView.tableFooterView = nil
        }
    }
    
    private func setupUI () {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        self.tableView.register(CharactersListItemTableViewCell.nib(), forCellReuseIdentifier: CharactersListItemTableViewCell.identifier)
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func navigateToCharacterDetails(with character: CharacterModel) {
        let characterDetailsViewController = CharacterDetailsViewController(character: character)
        self.navigationController?.pushViewController(characterDetailsViewController, animated: true)
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.pages.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersListItemTableViewCell.identifier, for: indexPath) as? CharactersListItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.configureCellWithCharacter(self.viewModel.getViewModel(for: indexPath))
        cell.didSelectItem = { [weak self] item in
            guard let character = self?.viewModel.didSelectItem(at: indexPath) else { return }
            self?.navigateToCharacterDetails(with: character)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.pages.characters.count-1 {
            self.viewModel.didLoadNextPage()
        }
    }
}
