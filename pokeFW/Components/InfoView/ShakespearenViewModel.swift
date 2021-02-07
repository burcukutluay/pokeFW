//
//  ShakespearenViewModel.swift
//  pokeFW
//
//  Created by burcu kirik on 7.02.2021.
//

import Foundation

struct ShakespearenViewModel: Codable {
        
    static func getShakespeareanDetail(text: String, url: String, successHandler: @escaping (ShakespeareanDetail) -> (), failHandler: @escaping (String) -> ()) {
        
        let url = url
        BaseService.shared.startRequest(url,
                                        method: .post,
                                        parameters: ["text": text],
                                        headers: nil,
                                        dataModel: ShakespeareanDetail.self,
                                        successHandler: { (data) in
                                            successHandler(data)
                                        }) { (error) in
            failHandler(error)
        }
    }
}

struct ShakespeareanDetail: Codable {
    var success: IsSuccess?
    var contents: SheakspeareanDetailContents?
}

struct IsSuccess: Codable {
    var total: Int?
}

struct SheakspeareanDetailContents: Codable {
    var translated: String?
    var text: String?
    var translation: String?
}
