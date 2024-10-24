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
    
    static var identifier: String { String(describing: self) }
    var cancelable = AnyCancellable(){}
    var didSelectItem: ((_ model: CharactersListItemViewModel)-> Void)?
    
    static func nib() -> UINib {
        let nib = UINib(nibName: CharactersListItemTableViewCell.identifier, bundle: nil)
        return nib
    }
    
    private lazy var characterCard: CharacterCardView = {
        let viewModel = CharacterCardViewModel()
        return CharacterCardView(viewModel: viewModel)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let characterCardView = UIHostingController(rootView: characterCard)
        contentView.addSubview(characterCardView.view)
        
        characterCardView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterCardView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            characterCardView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            characterCardView.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterCardView.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
        
        cancelable = characterCard.didTapCharacter.sink { [weak self] in
            print("List Item has been clicked")
            guard let self, let character = self.characterCard.viewModel.character else { return }
            self.didSelectItem?(character)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCellWithCharacter(_ characterViewModel: CharactersListItemViewModel) {
        characterCard.viewModel.character = characterViewModel
    }
}
