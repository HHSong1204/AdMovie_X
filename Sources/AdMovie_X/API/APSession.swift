//
//  APSession.swift
//  HHSong_AdMovie
//
//  Created by 송황호 on 2023/10/23.
//


import Foundation


/// AdPopcorn API Session
let API = APSession.shared

final class APSession {
    static let shared = APSession()
    
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    /// completion
    func request<T: Decodable>(target: TargetType,
                               type: T.Type,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: target.parameters, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                APLogger.info(selfType: self, "Request parameters", jsonString)
            }
        } catch {
//            APLogger.error(selfType: self, "Failed to convert dictionary to JSON string: \(error)")
        }
        session.dataTask(with: target.request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            guard let data = data else {
                completion(.failure(.error))
                return
            }
            switch httpResponse.statusCode {
                // Success
            case 200:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch _ {
                    completion(.failure(.error))
                }
            default:
                completion(.failure(.error))
            }
            if let _ = error {
                completion(.failure(.error))
                return
            }
        }.resume()
    }
    
}
