//
//  CharactersListViewModel.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import Foundation

enum CharactersListViewModelLoading {
   case fullScreen
   case nextPage
   case none
}

protocol CharactersListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSelectItem(at indexPath: IndexPath) -> CharacterModel
    func didSelectFilterChanged(status: String)
}


class CharactersListViewModel: CharactersListViewModelInput {
    
    private(set) var charactersUseCase: CharactersUseCase
    var pages: [CharactersModel] = [] {
        didSet{
            self.charactersCompletionHandler()
        }
    }
    
    private(set) var status: String = ""
    private(set) var totalPages = 1
    private(set) var pageSize = 20
    private(set) var currentPage = 0
    var nextPage: Int { currentPage + 1 }
     
    private(set) var loading: CharactersListViewModelLoading = .none {
        didSet {
            self.loadingCompletionHandler(loading)
        }
    }
     
    var error:(_ errMsg: String)->() = {_ in}
    var charactersCompletionHandler: ()->() = {}
    var loadingCompletionHandler:(_ loading: CharactersListViewModelLoading) -> () = {_ in}
    
    //MARK: - init
    init(charactersUseCase: CharactersUseCase) {
        self.charactersUseCase = charactersUseCase
    }
    
    //MARK:- Private
    private func appendPage(_ page: CharactersModel) {
        loading = .none
        currentPage = page.page
        totalPages = page.totalPages
        
        pages = pages
            .filter { $0.page != page.page }
            + [page]
    }
     
    private func load(loading: CharactersListViewModelLoading) {
        
        self.loading = loading
        let request = CharactersRequestValue(page: nextPage, status: status.lowercased())
        
        charactersUseCase.fetchCharacters(requestValue: request) { (result) in
            self.loading = .none
            
            switch result {
            case .success(let CharactersPage):
                self.appendPage(CharactersPage)
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }
   
    private func resetPages() {
        currentPage = 0
        totalPages = 0
        pages.removeAll()
    }
    
    func update() {
        resetPages()
        
        load(loading: .fullScreen)
    }
    
    func getViewModel(for indexPath: IndexPath) -> CharactersListItemViewModel {
        return CharactersListItemViewModel.init(character: self.pages.characters[indexPath.row])
    }
}


// MARK: - INPUT. View event methods
extension CharactersListViewModel {
    func viewDidLoad() {}
     
    func didSelectItem(at indexPath: IndexPath) -> CharacterModel {
        return pages.characters[indexPath.row]
    }
    
    func didLoadNextPage() {
        guard self.loading == .none, currentPage <= totalPages else {
            return
        }
        
        load(loading: .nextPage)
    }
    
    func didSelectFilterChanged(status: String) {
        resetPages()
        self.status = status
        
        load(loading: .fullScreen)
    }
}

// MARK: - Private

extension Array where Element == CharactersModel {
    var characters: [CharacterModel] { flatMap { $0.results } }
}
