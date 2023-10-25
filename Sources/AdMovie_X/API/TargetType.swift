//
//  TargetType.swift
//  HHSong_AdMovie
//
//  Created by 송황호 on 2023/10/23.
//

import Foundation

protocol TargetType {
    var path: String { get }
    //  var queryItems: [URLQueryItem] { get }
    var header: [String: String]? { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any] { get }
}

extension TargetType {
    var request: URLRequest {
        guard let url = URL(string: path) else { fatalError() }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue.uppercased()
        request.allHTTPHeaderFields = header
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
//        request.httpBody = jsonData
        return request
    }
}
