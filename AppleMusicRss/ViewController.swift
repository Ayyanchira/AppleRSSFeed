//
//  ViewController.swift
//  AppleMusicRss
//
//  Created by Akshay Ayyanchira on 3/1/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkServiceDelegate {
    //Instance properties
    var feed:Feed?
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialize view
        tableView.delegate = self
        tableView.register(CustomMusicCell.self, forCellReuseIdentifier: "MusicCell")
        //Make API Request
        requestForData()
    }

    
    fileprivate func requestForData() {
        let networkServiceManager = NetworkService()
        networkServiceManager.delegate = self
        networkServiceManager.requestForRSS()
    }

    //MARK:- Table view delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed == nil ? 0 : (feed?.feed.results.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MusicCell") as! CustomMusicCell
        let music = feed?.feed.results[indexPath.row]
        cell.musicName = music?.artistName
        let imageURL = URL(string: (feed?.feed.results[indexPath.row].artworkUrl100)!)
        let imageData = try? Data(contentsOf: imageURL!)
        DispatchQueue.main.async {
            cell.artistImage = UIImage(data: imageData!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    //MARK:- Network Service delegate methods
    func didFinishWithSuccess(feed: Feed) {
        self.feed = feed
        print("Lets add a table view now!")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFinishWithError() {
        showAlertWithMessage("Error occurred")
    }
    
    func didGetInterrupted() {
        showAlertWithMessage("Got interrupted")
    }
    
    func showAlertWithMessage(_ message:String) {
        let alertVC = UIAlertController(title: message, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
    }
}

