//
//  CharacterDetailsViewController.swift
//  Characters
//
//  Created by Mohamed Ramadan on 24/10/2024.
//

import UIKit
import SwiftUI

class CharacterDetailsViewController: UIViewController {
    
    static var identifier: String { String(describing: self) }
    
    var character: CharacterModel?
    
    convenience init(character: CharacterModel) {
        self.init()
        self.character = character
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let characterDetailsView = CharacterDetailsView(viewModel: .init(character: character))
        let characterCardView = UIHostingController(rootView: characterDetailsView)
       
        addChild(characterCardView)
        characterCardView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(characterCardView.view)
        characterCardView.didMove(toParent: self)

        NSLayoutConstraint.activate([
            characterCardView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            characterCardView.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            characterCardView.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterCardView.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        updateUI()
    }
     
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Private Methods

    func updateUI() {
        
    }
}
