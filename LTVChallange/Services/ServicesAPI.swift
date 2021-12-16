//
//  ServicesAPI.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 09-12-21.
//

import Foundation
import JNetworking

struct APIQueryParams {
    
}

/// This API will hold all API's related to Rick And Morty
enum ServicesAPI {
    case getArticles
}

extension ServicesAPI: APIProtocol {
    func httpMthodType() -> HTTPMethodType {
        var methodType = HTTPMethodType.get
        switch self {
        case .getArticles:
            methodType = .get
        }
        return methodType
    }

    func apiEndPath() -> String {
        var path = ""
        switch self {
        case .getArticles:
            path += ServicesConstants.articles
        }

        return path
    }

    func apiBasePath() -> String {
        switch self {
        case .getArticles:
            return ServicesConstants.baseURL
        }
    }

}
