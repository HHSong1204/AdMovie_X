//
//  MovieRouter.swift
//  HHSong_AdMovie
//
//  Created by 송황호 on 2023/10/23.
//

import Foundation


enum MovieRouter {
    case movie(token: String)
}
extension MovieRouter: TargetType {
    private enum BaseURL {
        case TMDB
        
        var url: String {
            switch self {
            case .TMDB: return "https://api.themoviedb.org/3"
            }
        }
    }
    
    var path: String {
        switch self {
        case .movie: return BaseURL.TMDB.url + "/movie/now_playing?language=ko-KR&page=1"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .movie(let token):
            return ["accept": "application/json",
                    "Authorization": "Bearer \(token)"]
        }
    }
    
    var parameters: [String: Any] {
        let parameter: [String: Any] = [:]
        switch self {
        case .movie:
            return parameter
        }
    }
}
