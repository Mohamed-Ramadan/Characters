//
//  CharactersListItemTableViewCell.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import UIKit

class CharactersListItemTableViewCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    static func nib() -> UINib {
        let nib = UINib(nibName: CharactersListItemTableViewCell.identifier, bundle: nil)
        return nib
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 16
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.clipsToBounds = true
        
        
        characterImageView.layer.cornerRadius = 8
        characterImageView.layer.borderWidth = 1
        characterImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCellWithCharacter(_ characterViewModel: CharactersListItemViewModel) {
        characterNameLabel.text = characterViewModel.name
        characterSpeciesLabel.text = characterViewModel.species
        
        let urlString = "\(characterViewModel.imageURL)"
        print(urlString)
        
        if let url = URL(string: urlString) {
            characterImageView.loadImage(from: url, identifier: "\(characterViewModel.id)")
        }
    }
}
