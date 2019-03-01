//
//  CustomMusicCell.swift
//  AppleMusicRss
//
//  Created by Akshay Ayyanchira on 3/1/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class CustomMusicCell: UITableViewCell {
    
    //properties
    var musicName: String?
    var musicNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label.textAlignment = .center
        return label
    }()
    
    var artistImage: UIImage?
    var artistImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        artistImageView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        musicNameLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.addSubview(artistImageView)
        self.addSubview(musicNameLabel)
        
        setConstraints()
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    
    
    fileprivate func setConstraints() {
        
        
        let orientation = UIDevice.current.orientation
        if orientation == .portrait {
            artistImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            artistImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            artistImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            artistImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            artistImageView.contentMode = .scaleAspectFit
            
            //musicNameLabel.leftAnchor.constraint(equalTo: self.artistImageView.rightAnchor).isActive = true
            musicNameLabel.centerXAnchor.constraint(equalTo: self.artistImageView.centerXAnchor).isActive = true
            musicNameLabel.topAnchor.constraint(equalTo: artistImageView.bottomAnchor, constant: 10).isActive = true
            //        musicNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            //       musicNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            //        musicNameLabel.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            //   musicNameLabel.centerYAnchor.constraint(equalTo: self.artistImageView.centerYAnchor).isActive = true
            musicNameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        }
        else {
            artistImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
            artistImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            artistImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            artistImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
//            artistImageView.contentMode = .scaleAspectFit
            
            musicNameLabel.leftAnchor.constraint(equalTo: self.artistImageView.rightAnchor, constant: 10).isActive = true
            //musicNameLabel.centerXAnchor.constraint(equalTo: self.artistImageView.centerXAnchor).isActive = true
            musicNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 150).isActive = true
            musicNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
        

        
//        self.bottomAnchor.constraint(equalTo: artistImageView.bottomAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        if let name = musicName{
            musicNameLabel.text = name
        }
        if let image = artistImage{
            artistImageView.image = image
        }
    }
    
    
}
