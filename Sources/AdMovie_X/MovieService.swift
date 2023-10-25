//
//  MovieService.swift
//  HHSong_AdMovie
//
//  Created by 송황호 on 2023/10/23.
//

import Foundation


class MovieService {
    
    func fetchMovie(token: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        API.request(target: MovieRouter.movie(token: token),
                    type: MovieList.self) { result in
            switch result {
            case .success(let data):
                let list = data.results
                completion(.success(list))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
