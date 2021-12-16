//
//  ServicesRequest.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 09-12-21.
//

import Foundation
import JNetworking

typealias GetArticlesResponse = (Result<Articles, Error>) -> Void

protocol ServicesRequestType {
    @discardableResult func getArticles(apiQueryModel: APIQueryParams, completion: @escaping GetArticlesResponse) -> URLSessionDataTask?
}

struct ServicesRequest: ServicesRequestType {
    
    func getArticles(apiQueryModel: APIQueryParams, completion: @escaping GetArticlesResponse) -> URLSessionDataTask? {
        let requestModel = APIRequestModel(api: ServicesAPI.getArticles)
        return JNWebserviceHelper.requestAPI(apiModel: requestModel) { response in
            switch response {
            case .success(let data):
                JNJSONResponseDecoder.decodeFrom(data, returningModelType: Articles.self, completion: { (allData, error) in
                    if let parserError = error {
                        completion(.failure(parserError))
                        return
                    }

                    if let data = allData {
                        completion(.success(data))
                    }
                })
            case .failure(let error):
                completion(.failure(error))
                }
            }
    }
    
    
}
