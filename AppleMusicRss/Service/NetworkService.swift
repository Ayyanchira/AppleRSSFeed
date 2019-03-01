//
//  NetworkService.swift
//  AppleMusicRss
//
//  Created by Akshay Ayyanchira on 3/1/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import Foundation

protocol NetworkServiceDelegate {
    func didFinishWithSuccess(feed:Feed)
    func didFinishWithError()
    func didGetInterrupted()
}

class NetworkService {
    var delegate:NetworkServiceDelegate?
    
    func requestForRSS() {
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json")
        let task = URLSession.shared.feedTask(with: url!) { feed, response, error in
            if let feed = feed {
                print("Things are going good till here...")
                if self.delegate == nil{
                    return
                }
                self.delegate?.didFinishWithSuccess(feed: feed)
            }else{
                print("Things are goin wrtong")
                self.delegate?.didFinishWithError()
            }
        }
        task.resume()
    }
}
