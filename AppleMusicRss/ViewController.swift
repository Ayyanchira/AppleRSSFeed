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
    
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialize view
        tableView.delegate = self
        
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "HI"
        return cell
    }
    
    
    //MARK:- Network Service delegate methods
    func didFinishWithSuccess(feed: Feed) {
        print("Success")
    }
    
    func didFinishWithError() {
        print("Error")
    }
    
    func didGetInterrupted() {
        print("Interupted")
    }
}

