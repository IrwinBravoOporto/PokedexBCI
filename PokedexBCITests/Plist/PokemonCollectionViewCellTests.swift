//
//  PokemonCollectionViewCellTests.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import XCTest
@testable import PokedexBCI

class PokemonCollectionViewCellTests: XCTestCase {
    var cell: PokemonCollectionViewCell!
    
    override func setUp() {
        super.setUp()
        cell = PokemonCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
    }
    
    func testConfigureCell() {
        // Given
        let pokemon = ResultPokeDex(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
        
        // When
        cell.configure(with: pokemon)
        
        // Then
        XCTAssertEqual(cell.lblName.text, "Pikachu")
        // Aquí podrías mockear ImageCache para verificar que se carga la imagen correctamente
    }
}
