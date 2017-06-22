//
//  GameDataService.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation
import Alamofire

class GameDataService {
    static let instance = GameDataService()
    
    var games = [Game]()
    
    func downloadnTopGames(completed: @escaping DownloadComplete) {
        
        let url = TWITCH_URL_TOP_GAMES
        var nameString, imageUrlString: String!
        
        request(url).responseJSON { (responce) in
            print(responce)
            if let JSON = responce.result.value as? [String:Any] {
                if let topGamesArray = JSON["top"] as? [[String:Any]], topGamesArray.count > 0 {
                    for i in topGamesArray {
                        if let gameDict = i["game"] as? [String:Any] {
                            if let gameName = gameDict["name"] as? String {
                                nameString = gameName
                            }
                            
                            if let boxArt = gameDict["box"] as? [String:Any] {
                                if let imageUrl = boxArt["large"] as? String {
                                    imageUrlString = imageUrl
                                }
                            }
                        }
                        
                        let game = Game(name: nameString, imageUrl: imageUrlString)
                        self.games.append(game)
                    }
                }
            }
            completed()
        }
    }
}
