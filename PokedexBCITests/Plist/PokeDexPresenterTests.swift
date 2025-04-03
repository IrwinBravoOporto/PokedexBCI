//
//  PokeDexPresenterTests.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import XCTest
@testable import PokedexBCI

class PokeDexPresenterTests: XCTestCase {
    var presenter: PokeDexPresenter!
    var mockView: MockPokeDexView!
    var mockInteractor: MockPokeDexInteractor!
    var mockRouter: MockPokeDexRouter!
    
    override func setUp() {
        super.setUp()
        mockView = MockPokeDexView()
        mockInteractor = MockPokeDexInteractor()
        mockRouter = MockPokeDexRouter()
        presenter = PokeDexPresenter(
            interface: mockView,
            interactor: mockInteractor,
            router: mockRouter
        )
        mockInteractor.presenter = presenter // Conectamos el interactor con el presenter
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    // MARK: - Load Pokemons
    func testLoadPokemonsSuccess() {
        // Given
        let mockPokemons = [
            ResultPokeDex(name: "pikachu", url: "url1"),
            ResultPokeDex(name: "bulbasaur", url: "url2")
        ]
        mockInteractor.mockResult = .success(mockPokemons)
        
        // When
        presenter.loadPokemons()
        
        // Simula el paso del tiempo para operaciones asíncronas
        RunLoop.current.run(until: Date() + 0.1)
        
        // Then
        XCTAssertTrue(mockView.showLoadingCalled)
        XCTAssertTrue(mockView.hideLoadingCalled)
        
        // Verifica el estado interno del presenter
        XCTAssertEqual(presenter.numberOfPokemons, 2)
        XCTAssertEqual(presenter.pokemon(at: 0)?.name, "pikachu")
        XCTAssertEqual(presenter.pokemon(at: 1)?.name, "bulbasaur")
        XCTAssertNil(presenter.pokemon(at: 2))  // Índice fuera de rango
        
        XCTAssertTrue(mockView.reloadCollectionViewCalled)
        XCTAssertFalse(mockView.showErrorCalled)
    }
    
    func testLoadPokemonsFailure() {
        // Given
        mockInteractor.mockResult = .failure(NSError(domain: "Test", code: 500))
        
        // When
        presenter.loadPokemons()
        
        // Simulamos el retraso asíncrono
        RunLoop.current.run(until: Date() + 0.1)
        
        // Then
        XCTAssertTrue(mockView.showLoadingCalled)
        XCTAssertTrue(mockView.hideLoadingCalled)
        XCTAssertTrue(mockView.showErrorCalled)
    }
    
    // MARK: - Search
    func testSearchPokemon() {
        let mockPokemons = [
            ResultPokeDex(name: "pikachu", url: "url1"),
            ResultPokeDex(name: "charizard", url: "url2")
        ]
        presenter.pokemons = mockPokemons
        presenter.filteredPokemons = mockPokemons
        
        presenter.searchPokemon(with: "char")
        
        // Then
        XCTAssertEqual(presenter.numberOfPokemons, 1)
        XCTAssertEqual(presenter.pokemon(at: 0)?.name, "charizard")
        XCTAssertTrue(mockView.reloadCollectionViewCalled)
    }
    
    func testCancelSearch() {
        // Given
        let mockPokemons = [ResultPokeDex(name: "pikachu", url: "url1")]
        presenter.pokemons = mockPokemons
        presenter.filteredPokemons = []
        mockView.reloadCollectionViewCalled = false // Reset
        
        // When
        presenter.cancelSearch()
        
        // Then
        XCTAssertEqual(presenter.filteredPokemons.count, 1)
        XCTAssertEqual(presenter.filteredPokemons.first?.name, "pikachu")
        XCTAssertTrue(mockView.reloadCollectionViewCalled)
    }
    
    func testNumberOfPokemons() {
        // Given
        let mockPokemons = [
            ResultPokeDex(name: "pikachu", url: "url1"),
            ResultPokeDex(name: "bulbasaur", url: "url2")
        ]
        presenter.filteredPokemons = mockPokemons
        
        // When/Then
        XCTAssertEqual(presenter.numberOfPokemons, 2)
    }
    
    func testPokemonAtIndex() {
        // Given
        let mockPokemons = [
            ResultPokeDex(name: "pikachu", url: "url1"),
            ResultPokeDex(name: "bulbasaur", url: "url2")
        ]
        presenter.filteredPokemons = mockPokemons
        
        // When/Then
        XCTAssertEqual(presenter.pokemon(at: 0)?.name, "pikachu")
        XCTAssertEqual(presenter.pokemon(at: 1)?.name, "bulbasaur")
        XCTAssertNil(presenter.pokemon(at: 2))
    }
    
    func testSearchWithEmptyString() {
        // Given
        let mockPokemons = [
            ResultPokeDex(name: "pikachu", url: "url1"),
            ResultPokeDex(name: "charizard", url: "url2")
        ]
        presenter.pokemons = mockPokemons
        presenter.filteredPokemons = []
        
        // When
        presenter.searchPokemon(with: "")
        
        // Then
        XCTAssertEqual(presenter.numberOfPokemons, 2)
        XCTAssertTrue(mockView.reloadCollectionViewCalled)
    }
    
    func testSearchWithNoResults() {
        // Given
        let mockPokemons = [
            ResultPokeDex(name: "pikachu", url: "url1"),
            ResultPokeDex(name: "charizard", url: "url2")
        ]
        presenter.pokemons = mockPokemons
        
        // When
        presenter.searchPokemon(with: "zzzz")
        
        // Then
        XCTAssertEqual(presenter.numberOfPokemons, 0)
        XCTAssertTrue(mockView.reloadCollectionViewCalled)
    }
    
    func testSearchCaseInsensitive() {
        // Given
        let mockPokemons = [
            ResultPokeDex(name: "pikachu", url: "url1"),
            ResultPokeDex(name: "charizard", url: "url2")
        ]
        presenter.pokemons = mockPokemons
        
        // When
        presenter.searchPokemon(with: "PIKA")
        
        // Then
        XCTAssertEqual(presenter.numberOfPokemons, 1)
        XCTAssertEqual(presenter.pokemon(at: 0)?.name, "pikachu")
    }
    
    func testSelectPokemon() {
        // Given
        let mockPokemons = [
            ResultPokeDex(name: "pikachu", url: "url1"),
            ResultPokeDex(name: "charizard", url: "url2")
        ]
        presenter.filteredPokemons = mockPokemons
        
        // When
        presenter.didSelectPokemon(at: 1)
        
        // Then
        XCTAssertTrue(mockRouter.navigateToDetailCalled)
        XCTAssertEqual(mockRouter.lastSelectedPokemon?.name, "charizard")
    }
    
    func testInitialState() {
        XCTAssertEqual(presenter.numberOfPokemons, 0)
        XCTAssertNil(presenter.pokemon(at: 0))
        XCTAssertFalse(presenter.isSearching)
    }
    
    func testIsSearchingFlag() {
        // Given
        let mockPokemons = [
            ResultPokeDex(name: "pikachu", url: "url1"),
            ResultPokeDex(name: "charizard", url: "url2")
        ]
        presenter.pokemons = mockPokemons
        
        // When
        presenter.searchPokemon(with: "char")
        
        // Then
        XCTAssertTrue(presenter.isSearching)
        
        // When
        presenter.cancelSearch()
        
        // Then
        XCTAssertFalse(presenter.isSearching)
    }
    
    func testPerformanceForLargePokemonList() {
        // Given
        var largeList: [ResultPokeDex] = []
        for i in 0..<1000 {
            largeList.append(ResultPokeDex(name: "pokemon\(i)", url: "url\(i)"))
        }
        mockInteractor.mockResult = .success(largeList)
        
        // When & Then
        measure {
            presenter.loadPokemons()
            RunLoop.current.run(until: Date() + 0.1)
        }
    }
    
    func testNetworkErrorShowsCorrectMessage() {
        // Given
        let testError = NSError(domain: "Test", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not found"])
        mockInteractor.mockResult = .failure(testError)
        
        // When
        presenter.loadPokemons()
        RunLoop.current.run(until: Date() + 0.1)
        
        // Then
        XCTAssertTrue(mockView.showErrorCalled)
        XCTAssertEqual(mockView.lastErrorMessage, "Not found")
    }
    
    
    
}

// MARK: - Mocks Actualizados
class MockPokeDexView: PokeDexViewProtocol {
    var presenter: (any PokedexBCI.PokeDexPresenterProtocol)?
    
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var showErrorCalled = false
    var reloadCollectionViewCalled = false
    var playAnimationCalled = false
    
    var hideLoadingHandler: (() -> Void)?
    
    func hideLoading() {
        hideLoadingCalled = true
        hideLoadingHandler?()
    }
    
    func showLoading() { showLoadingCalled = true }
    //func hideLoading() { hideLoadingCalled = true }
    //func showError(message: String) { showErrorCalled = true }
    func showPokemons(_ pokemons: [ResultPokeDex]) {}
    func updateSearchResults(_ results: [ResultPokeDex]) {}
    func playBackgroundAnimation() { playAnimationCalled = true }
    func reloadCollectionView() { reloadCollectionViewCalled = true }
    
    var lastErrorMessage: String?

    func showError(message: String) {
        showErrorCalled = true
        lastErrorMessage = message
    }
}

class MockPokeDexInteractor: PokeDexInteractorInputProtocol {
    weak var presenter: PokeDexInteractorOutputProtocol?
    var mockResult: Result<[ResultPokeDex], Error> = .success([])
    
    func fetchAllPokemons(completion: @escaping (Result<[ResultPokeDex], Error>) -> Void) {
        // Simulamos el comportamiento asíncrono real
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.05) {
            completion(self.mockResult)
        }
    }
}

class MockPokeDexRouter: PokeDexWireframeProtocol {
    var navigateToDetailCalled = false
    
    static func createPokeDexModule() -> UIViewController {
        return UIViewController()
    }
    
    // En MockPokeDexRouter:
    var lastSelectedPokemon: ResultPokeDex?
    
    func navigateToPokemonDetail(from view: PokeDexViewProtocol?, with pokemon: ResultPokeDex) {
        navigateToDetailCalled = true
        lastSelectedPokemon = pokemon
    }
}
