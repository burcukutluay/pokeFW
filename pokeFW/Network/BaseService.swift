//
//  BaseService.swift
//  pokeFW
//
//  Created by burcu kirik on 6.02.2021.
//

import Foundation
import Alamofire
import CodableAlamofire

final class BaseService {

    static let shared = BaseService()
    private init(){}

    fileprivate var requestURL = ""
    internal var errorCode = ""


    fileprivate var sessionManager: Session {
        let sessionManager = Alamofire.Session.default
        sessionManager.session.configuration.timeoutIntervalForRequest = 30
        sessionManager.session.configuration.requestCachePolicy = .reloadIgnoringCacheData
        return sessionManager
    }


    internal final func getServiceHeader() -> [String: String] {
        return ["Content-Type": "application/json",
                "Accept-Language": "en-EN",
                "Cache-Control": "no-cache",
                "ApplicationVersion": "1.0",
                "DeviceManufacturer": "Apple",
                "ClientType": "ios",
                "Authorization": "noNeed"]
    }

    fileprivate final func getEncodingType(_ method: HTTPMethod, _ headers: HTTPHeaders?) -> ParameterEncoding {

        switch method {
        case .get, .delete:
            return URLEncoding.default
        case .put, .post:
            if headers != nil {
                return URLEncoding.default
            }
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }

    internal final let tokenHeader: [String : String] = ["Content-Type": "application/x-www-form-urlencoded",
                                                         "Accept": "application/json",
                                                         "Cache-Control": "no-cache, no-store, must-revalidate",
                                                         "Pragma": "no-cache"]

    let decoder = JSONDecoder()
    internal final var shouldReloadManager = false

    internal final var shouldRetry = true
    internal final var retryCounter: Int = 1 {
        didSet {
            shouldRetry = retryCounter > 5 ? false : true
        }
    }

    public func startRequest<T: Decodable>(_ url: String,
                                           method: Alamofire.HTTPMethod,
                                           parameters: [String : Any]?,
                                           headers: HTTPHeaders?,
                                           dataModel: T.Type,
                                           successHandler: @escaping (T) -> (),
                                           failHandler: @escaping (String) -> ()) {

        if UIDevice.current.hasConnection() {

            if let safeUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                requestURL = safeUrl
            } else {
                failHandler("unexpected error")
            }

            sessionManager.request(requestURL,
                                   method: method,
                                   parameters: parameters,
                                   encoding: getEncodingType(method, headers),
                                   headers: headers).validate().responseDecodableObject(decoder: self.decoder,
                                                                                        completionHandler: { (response: AFDataResponse<T>) in
                                                                                            switch response.result {
                                                                                            case .success(let value):
                                                                                                successHandler(value)
                                                                                                break
                                                                                            case .failure:
                                                                                                print("Error : \(response)")
                                                                                                failHandler(self.errorCode)
                                                                                                break
                                                                                            }
                                                                                        })
        } else {
            print("error")
        }

    }
}
