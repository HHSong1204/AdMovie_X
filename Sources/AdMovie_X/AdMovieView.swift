//
//  AdMovieView.swift
//  HHSong_AdMovie
//
//  Created by 송황호 on 2023/10/23.
//

import UIKit


@objc
public protocol AdMovieViewDelegate: AnyObject {
  @objc optional func adMovieViewSuccess()
  @objc optional func adMovieViewFail(error: NetworkError)
}

final public class AdMovieView: UIView {
    
    public var delegate: AdMovieViewDelegate?
    
    private var service = MovieService()
    
    private var posterImage = UIImageView()
    
    private let token: String
    
    public init(token: String) {
        self.token = token
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [posterImage].forEach {
            addSubview($0)
        }
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        posterImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    public func load() {
        service.fetchMovie(token: token) { result in 
            switch result {
            case .success(let movieList):
                self.setupMovie(movieList: movieList)
                self.delegate?.adMovieViewSuccess?()
                
            case .failure(let failure):
                self.delegate?.adMovieViewFail?(error: failure)
            }
        }
    }
    
    private func setupMovie(movieList: [Movie]) {
        let random = Int.random(in: 0..<movieList.count)
        let imageString = movieList[random].posterPath
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w342\(imageString)") else {
            return
        }
        posterImage.load(url: url)
    }
    
}
