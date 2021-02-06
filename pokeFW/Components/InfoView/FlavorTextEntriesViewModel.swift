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
}

struct FlavorText: Codable {
    var flavor_text: String?
}
