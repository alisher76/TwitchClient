//
//  Game.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit
import Alamofire

class Game {
    
    var gameName: String!
    var gameImageUrl: String!
    var gameImage: UIImage?
    
    init(name: String, imageUrl: String) {
        self.gameName = name
        self.gameImageUrl = imageUrl
    }
    
    func downloadGameImage(completed: @escaping DownloadComplete) {
        request(gameImageUrl).responseData { (responce) in
            if let data = responce.result.value{
                if let image = UIImage(data: data){
                self.gameImage = image
              }
          }
        completed()
      }
    }
    
}
