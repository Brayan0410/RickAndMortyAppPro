//
//  CharacterListView.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject  var viewModel : CharacterListViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showNoInternetAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Filtrar por especie", text: $viewModel.selectedSpecies)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .onSubmit {
                        Task { await viewModel.loadCharacters() }
                    }

                content
            }
            .navigationTitle("Personajes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Estado", selection: $viewModel.selectedStatus) {
                            Text("All").tag("All")
                            Text("Alive").tag("Alive")
                            Text("Dead").tag("Dead")
                            Text("unknown").tag("unknown")
                        }
                    } label: {
                        Label("Estado", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Buscar por nombre")
            
            .onChange(of: viewModel.selectedStatus) { _ in
                Task { await viewModel.loadCharacters() }
            }
            .onChange(of: networkMonitor.isConnected) { connected in

                if connected {
                    Task {
                        await viewModel.loadCharacters()
                    }
                }
            }
        }
        .task {

            if networkMonitor.isConnected {

                await viewModel.loadCharacters()

            } else {

                showNoInternetAlert = true
            }
        }.alert("Sin conexión a internet", isPresented: $showNoInternetAlert) {
            
            Button("Ver favoritos") {
            }

            Button("Reintentar") {

                if networkMonitor.isConnected {
                    Task {
                        await viewModel.loadCharacters()
                    }
                } else {
                    showNoInternetAlert = true
                }
            }

        } message: {

            Text("Puedes conectarte a internet o ver tus personajes favoritos guardados.")
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.characters.isEmpty {
            loadingView
        } else if let error = viewModel.errorMessage {
            errorView(error)
        } else if viewModel.characters.isEmpty {
            emptyView
        } else {
            characterList
        }
    }
    
    private var loadingView: some View {
        ProgressView("Cargando personajes...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func errorView(_ error: String) -> some View {
        VStack {
            Text("Error: \(error)")
                .foregroundColor(.red)
                .padding()
            Button("Reintentar") {
                Task {
                    await viewModel.loadCharacters()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyView: some View {
        Text("No se encontraron personajes.")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var characterList: some View {
        List {
            ForEach(viewModel.characters) { character in
                NavigationLink(
                    destination: CharacterDetailView(
                        viewModel: CharacterDetailViewModel(
                            character: character,
                            episodeRepository: EpisodeRepository(apiClient: APIClient())
                        )
                    )
                ) {
                    CharacterRowView(character: character)
                }
            }
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.refreshCharacters()
        }
    }
}
