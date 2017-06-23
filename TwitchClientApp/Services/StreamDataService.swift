//
//  StreamDataService.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Alamofire
import Foundation

class StreamDataService {
    
    static let instance = StreamDataService()
    
    var streams = [Stream]()
    
    func downloadStreamsForGame(_ game: Game, completed: @escaping DownloadComplete) {
        var viewerCountDouble: Double!
        var imageUrlString, nameString, titleString: String!
        //GET /streams
        let gameString = game.gameName.replacingOccurrences(of: " ", with: "+")
        let url = TWITCH_URL_STREAMS_BASE + gameString + TWITCH_URL_STREAMS_CLIENT_ID
        
        request(url).responseJSON { (response) in
            print(response)
            if let JSON = response.result.value as? [String : Any] {
                print(JSON)
                if let streamsArray = JSON["streams"] as? [Dictionary<String, Any>], streamsArray.count > 0 {
                    print(streamsArray)
                    for i in 0..<streamsArray.count {
                        if let viewerCount = streamsArray[i]["viewers"] as? Double {
                            viewerCountDouble = viewerCount
                        }
                        
                        if let imageDict = streamsArray[i]["preview"] as? [String : Any] {
                            if let imageUrl = imageDict["large"] as? String {
                                imageUrlString = imageUrl
                            }
                        }
                        
                        if let channelDict = streamsArray[i]["channel"] as? [String : Any] {
                            if let name = channelDict["display_name"] as? String {
                                nameString = name
                            }
                            
                            if let title = channelDict["status"] as? String {
                                titleString = title
                            }
                        }
                        let stream = Stream(name: nameString, title: titleString, viewerCount: viewerCountDouble, imageUrl: imageUrlString)
                        self.streams.append(stream)
                    }
                }
            }
            
            completed()
        }
    }
    
    func removeAllStreams() {
        streams.removeAll()
    }
}
