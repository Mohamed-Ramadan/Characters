//
//  CharacterDetailsView.swift
//  Characters
//
//  Created by Mohamed Ramadan on 24/10/2024.
//

import SwiftUI

class CharacterDetailsViewModel: ObservableObject {
    @Published var character: CharacterModel?
    
    init(character: CharacterModel? = nil) {
        self.character = character
    }
}

struct CharacterDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CharacterDetailsViewModel
    
    let imageHeight: CGFloat = 400
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                VStack(spacing: 30) {
                    
                    ZStack(alignment: .topLeading) {
                        AsyncImage(url: URL(string: viewModel.character?.image ?? "")) { image in
                            image
                                .resizable()
                                .cornerRadius(16)
                        } placeholder: {
                            ProgressView()
                        }
                        .ignoresSafeArea()
                        .frame(width: geometry.size.width, height: imageHeight)
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            ZStack(alignment: .center) {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 50, height: 50)
                                Image(systemName: "arrow.backward")
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.black)
                                    .font(.headline)
                                
                            }
                        }
                        .offset(x: 20, y: 50)
                    }
                    .frame(height: imageHeight)
                    
                    VStack(alignment: .leading, spacing: 30) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(viewModel.character?.name ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                HStack(alignment: .center) {
                                    Text(viewModel.character?.species ?? "")
                                        .font(.title2)
                                    Circle()
                                        .fill(.black)
                                        .frame(width: 5, height: 5)
                                    Text(viewModel.character?.gender ?? "")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                            
                            Text(viewModel.character?.status ?? "")
                                .font(.body)
                                .foregroundColor(.white)
                                .background {
                                    Rectangle()
                                        .fill(.blue)
                                        .cornerRadius(17.5)
                                        .frame(height: 35)
                                        .padding(-15)
                                }
                                .padding()
                        }
                        
                        HStack {
                            Text("Location :")
                                .font(.title2)
                            Text(viewModel.character?.location.name ?? "")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                }
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    let character = CharacterModel(id: 1, name: "Zephyr", status: "Alive", species: "Elf", type: "", gender: "Male", origin: .init(name: "Earth", url: ""), location: .init(name: "Earth", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [], url: "", created: "")
    CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: character))
}
