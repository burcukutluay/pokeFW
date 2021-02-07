//
//  SpriteViewModel.swift
//  pokeFW
//
//  Created by burcu kirik on 6.02.2021.
//

import Foundation
import UIKit

struct SpriteViewModel: Codable {
    
    var sprites: Sprites?
    
    static func getSprite(url: String, successHandler: @escaping (Sprites) -> (), failHandler: @escaping (String) -> ()) {
        
        let url = url
        BaseService.shared.startRequest(url,
                                        method: .get,
                                        parameters: nil,
                                        headers: nil,
                                        dataModel: Sprites.self,
                                        successHandler: { (data) in
                                            successHandler(data)
                                        }) { (error) in
            failHandler(error)
        }
    }
    
    static func getSprite(infoView: UIView, url: String, successHandler: @escaping (Sprites) -> (), failHandler: @escaping (String) -> (), completionHandler: @escaping (UIView) -> ()) {
        
        let url = url
        BaseService.shared.startRequest(url,
                                        method: .get,
                                        parameters: nil,
                                        headers: nil,
                                        dataModel: Sprites.self,
                                        successHandler: { (data) in
                                            successHandler(data)
                                            completionHandler(infoView)
                                        }) { (error) in
            failHandler(error)
        }
    }
}

struct Sprites: Codable {
    var sprites: Sprite?
    var other: OtherSprite?
}

struct Sprite: Codable {
    var back_default: String?
    var back_female: String?
    var back_shiny: String?
    var back_shiny_female: String?
    var front_default: String?
    var front_female: String?
    var front_shiny: String?
    var front_shiny_female: String?
}

struct OtherSprite: Codable {
    var dream_world: [FrontURL]?
}

struct FrontURL: Codable {
    var front_default: String?
}
