//
//  ViewController.swift
//  AppleMusicRss
//
//  Created by Akshay Ayyanchira on 3/1/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import SDWebImage

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
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
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
        //let imageData = try? Data(contentsOf: imageURL!)
        cell.artistImageView.sd_setImage(with: imageURL) { (image, error, cachetype, url) in
            if let imageFetched = image{
                let averageColor = imageFetched.averageColor
                if let bgcolor = averageColor{
                    UIView.animate(withDuration: 0.2) {
                        self.view.backgroundColor = bgcolor
                    }
                    
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
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

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}

