//
//  FlavorTextEntriesViewModel.swift
//  pokeFW
//
//  Created by burcu kirik on 6.02.2021.
//

import Foundation

struct FlavorTextEntriesViewModel: Codable {
    
    var results: PokeDetail?
    
    static func getFlavorTextEntries(url: String, successHandler: @escaping (PokeDetail) -> (), failHandler: @escaping (String) -> ()) {
        
        let url = url
        BaseService.shared.startRequest(url,
                                        method: .get,
                                        parameters: nil,
                                        headers: nil,
                                        dataModel: PokeDetail.self,
                                        successHandler: { (data) in
                                            successHandler(data)
        }) { (error) in
            failHandler(error)
        }
    }
}


struct PokeDetail: Codable {
    var base_happiness: Int?
    var id: Int?
    var flavor_text_entries: [FlavorText]?
    var varieties: [Varieties]?
}

struct FlavorText: Codable, Equatable {
    
    static func == (lhs: FlavorText, rhs: FlavorText) -> Bool {
        var lhs_flavor_text = lhs.flavor_text ?? ""
        lhs_flavor_text = lhs_flavor_text.replacingOccurrences(of: "\n", with: " ")
        lhs_flavor_text = lhs_flavor_text.replacingOccurrences(of: "\u{0C}", with: " ")
        
        var rhs_flavor_text = rhs.flavor_text ?? ""
        rhs_flavor_text = rhs_flavor_text.replacingOccurrences(of: "\n", with: " ")
        rhs_flavor_text = rhs_flavor_text.replacingOccurrences(of: "\u{0C}", with: " ")
        return lhs_flavor_text == rhs_flavor_text ? true : false
    }
    
    var flavor_text: String?
    var language: NameURL?
}

struct Varieties: Codable {
    var is_default: Bool?
    var pokemon: Pokemon?
}

struct NameURL: Codable {
    var name: String?
    var url: String?
}

struct Pokemon: Codable {
    var name: String?
    var url: String?
}
