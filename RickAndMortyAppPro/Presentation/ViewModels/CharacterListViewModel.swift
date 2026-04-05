//
//  CharacterListViewModel.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation
import Combine

@MainActor
final class CharacterListViewModel: ObservableObject {

    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var searchText: String = ""
    @Published var selectedStatus: String = "All"
    @Published var selectedSpecies: String = ""
    private var cancellables = Set<AnyCancellable>()

    private let characterRepository: CharacterRepositoryProtocol

    private var currentPage = 1
    private var canLoadMorePages = true
    private var isLoadingPage = false

    init(characterRepository: CharacterRepositoryProtocol) {
        self.characterRepository = characterRepository
        setupSearchDebounce()
        setupSpeciesDebounce()
    }

    func loadCharacters() async {

        currentPage = 1
        canLoadMorePages = true
        characters = []

        await loadNextPage()
    }

    func loadNextPage() async {

        guard !isLoadingPage && canLoadMorePages else { return }

        isLoadingPage = true
        isLoading = true
        errorMessage = nil

        do {

            let filters = CharacterFilters(
                name: searchText.isEmpty ? nil : searchText,
                status: selectedStatus == "All" ? nil : selectedStatus,
                species: selectedSpecies.isEmpty ? nil : selectedSpecies
            )

            let fetched = try await characterRepository.fetchCharacters(
                page: currentPage,
                filters: filters
            )

            characters.append(contentsOf: fetched)

            canLoadMorePages = !fetched.isEmpty

            currentPage += 1

        } catch {

            errorMessage = error.localizedDescription
        }

        isLoading = false
        isLoadingPage = false
    }

    func refreshCharacters() async {
        await loadCharacters()
    }
    private func setupSearchDebounce() {
        
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                
                Task {
                    await self?.loadCharacters()
                }
                
            }
            .store(in: &cancellables)
    }
    private func setupSpeciesDebounce() {

        $selectedSpecies
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                Task {
                    await self?.loadCharacters()
                }
            }
            .store(in: &cancellables)
    }
}
