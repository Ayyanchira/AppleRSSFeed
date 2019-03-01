//
//  Feed.swift
//  AppleMusicRss
//
//  Created by Akshay Ayyanchira on 3/1/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//
// To parse the JSON, add this file to your project and do:
//
//   let feed = try? newJSONDecoder().decode(Feed.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.feedTask(with: url) { feed, response, error in
//     if let feed = feed {
//       ...
//     }
//   }
//   task.resume()

import Foundation

class Feed: Codable {
    let feed: FeedClass
    
    init(feed: FeedClass) {
        self.feed = feed
    }
}

class FeedClass: Codable {
    let title: String
    let id: String
    let author: Author
    let links: [Link]
    let copyright, country: String
    let icon: String
    let updated: String
    let results: [Result]
    
    init(title: String, id: String, author: Author, links: [Link], copyright: String, country: String, icon: String, updated: String, results: [Result]) {
        self.title = title
        self.id = id
        self.author = author
        self.links = links
        self.copyright = copyright
        self.country = country
        self.icon = icon
        self.updated = updated
        self.results = results
    }
}

class Author: Codable {
    let name: String
    let uri: String
    
    init(name: String, uri: String) {
        self.name = name
        self.uri = uri
    }
}

class Link: Codable {
    let linkSelf: String?
    let alternate: String?
    
    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
        case alternate
    }
    
    init(linkSelf: String?, alternate: String?) {
        self.linkSelf = linkSelf
        self.alternate = alternate
    }
}

class Result: Codable {
    let artistName, id, releaseDate, name: String
    let kind: Kind
    let copyright, artistID: String
    let artistURL: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
    let contentAdvisoryRating: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName, id, releaseDate, name, kind, copyright
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url, contentAdvisoryRating
    }
    
    init(artistName: String, id: String, releaseDate: String, name: String, kind: Kind, copyright: String, artistID: String, artistURL: String, artworkUrl100: String, genres: [Genre], url: String, contentAdvisoryRating: String?) {
        self.artistName = artistName
        self.id = id
        self.releaseDate = releaseDate
        self.name = name
        self.kind = kind
        self.copyright = copyright
        self.artistID = artistID
        self.artistURL = artistURL
        self.artworkUrl100 = artworkUrl100
        self.genres = genres
        self.url = url
        self.contentAdvisoryRating = contentAdvisoryRating
    }
}

class Genre: Codable {
    let genreID, name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
    
    init(genreID: String, name: String, url: String) {
        self.genreID = genreID
        self.name = name
        self.url = url
    }
}

enum Kind: String, Codable {
    case album = "album"
}

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }   
    }
    
    func feedTask(with url: URL, completionHandler: @escaping (Feed?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
