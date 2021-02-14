//
//  pokeFWTests.swift
//  pokeFWTests
//
//  Created by burcu kirik on 14.02.2021.
//

import XCTest
import pokeFW
import UIKit

@testable import pokeFW

class pokeFWTests: XCTestCase {
    
    func testValidFlavorTextEntries() throws {
        // pikachu search result is not null or empty:
        let promise = expectation(description: "Flavor text API call success")
        let url = "https://pokeapi.co/api/v2/pokemon-species/pikachu"
        // create dataTask:
        let _ = FlavorTextEntriesViewModel.getFlavorTextEntries(url: url) { (detail) in
            if detail.id != nil {
                promise.fulfill()
            }
        } failHandler: { (error) in
            print(error)
            XCTFail("Error: \(error)")
        }
        wait(for: [promise], timeout: 20)
    }
    
    func testValidShakespeareanText() throws {
        let promise = expectation(description: "Shakespeare text API call success")
        let url = "https://api.funtranslations.com/translate/shakespeare.json"
        // warmadam search result is not null or empty and text is mock:
        let wormadamText = "When BURMY evolved, its cloak became a part of this Pokémon’s body. The cloak is never shed.Its appearance changes depending on where it evolved. The materials on hand become a part of its body.When evolving, its body takes in surrounding materials. As a result, there are many body variations.It is said that a WORMADAM that evolves on a cold day will have a thicker cloak.When Burmy evolved, its cloak became a part of this Pokémon’s body. The cloak is never shed."
        let _ = ShakespearenViewModel.getShakespeareanDetail(text: wormadamText, url: url) { (detail) in
            if !(detail.contents?.translated?.isEmpty ?? true) {
                promise.fulfill()
            }
            else {
                XCTFail("Error: No content found, check ratelimit!")
            }
        } failHandler: { (error) in
            print(error)
            XCTFail("Error: \(error)")
        }
        wait(for: [promise], timeout: 20)
    }
    
    func testEmptyShakespeareanText() throws {
        let promise = expectation(description: "Shakespeare empty text API call returns empty success")
        let url = "https://api.funtranslations.com/translate/shakespeare.json"
        // pikachu search result is not null or empty and text is mock:
        let pikachuText = ""
        let _ = ShakespearenViewModel.getShakespeareanDetail(text: pikachuText, url: url) { (detail) in
            if !(detail.contents?.translated?.isEmpty ?? true) {
                XCTFail("Error: No content should be found")
            }
            else {
                promise.fulfill()
            }
        } failHandler: { (error) in
            print(error)
            XCTFail("Error: \(error)")
        }
        wait(for: [promise], timeout: 20)
    }
    
}
