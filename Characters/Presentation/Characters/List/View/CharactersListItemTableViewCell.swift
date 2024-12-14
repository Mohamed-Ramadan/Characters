//
//  CharactersListItemTableViewCell.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import UIKit
import SwiftUI
import Combine

class CharactersListItemTableViewCell: UITableViewCell {
    // MARK: - Properties
    static var identifier: String { String(describing: self) }
    var cancelable = AnyCancellable(){}
    var didSelectItem: ((_ model: CharactersListItemViewModel)-> Void)?
    
    private lazy var characterCard: CharacterCardView = {
        let viewModel = CharacterCardViewModel()
        return CharacterCardView(viewModel: viewModel)
    }()
    
    private var characterCardViewController: UIHostingController<CharacterCardView>?
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        bindCharacterCardActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Embed the SwiftUI `CharacterCardView` into the cell
        let hostingController = UIHostingController(rootView: characterCard)
        characterCardViewController = hostingController
        
        guard let cardView = hostingController.view else { return }
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
        
        // Add Auto Layout constraints
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Binding Actions
    private func bindCharacterCardActions() {
        cancelable = characterCard.didTapCharacter.sink { [weak self] in
            print("List Item has been clicked")
            guard let self, let character = self.characterCard.viewModel.character else { return }
            self.didSelectItem?(character)
        }
    }
    
    func configureCellWithCharacter(_ characterViewModel: CharactersListItemViewModel) {
        characterCard.viewModel.character = characterViewModel
    }
}
