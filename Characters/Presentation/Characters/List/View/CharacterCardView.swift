//
//  CharacterCardView.swift
//  Characters
//
//  Created by Mohamed Ramadan on 21/10/2024.
//

import SwiftUI
import Combine

class CharacterCardViewModel: ObservableObject {
    @Published var character: CharactersListItemViewModel?
    
    init(character: CharactersListItemViewModel? = nil) {
        self.character = character
    }
}

struct CharacterCardView: View {
    
    @ObservedObject var viewModel: CharacterCardViewModel
    var didTapCharacter = PassthroughSubject<Void, Never>()
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: viewModel.character?.imageURL ?? "")) { image in
                image.resizable()
                    .scaledToFit()
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.character?.name ?? "")
                    .font(.headline)
                Text(viewModel.character?.species ?? "")
                    .font(.subheadline)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, idealHeight: 128,  alignment: .leading)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
        .onTapGesture {
            didTapCharacter.send()
        }
    }
}

#Preview {
    let character = CharactersListItemViewModel(id: 1, name: "Zephyr", status: "Alive", type: "", imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Elf")
    CharacterCardView(viewModel: CharacterCardViewModel(character: character))
}
