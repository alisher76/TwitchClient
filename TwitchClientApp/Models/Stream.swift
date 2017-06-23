//
//  Stream.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Alamofire
import Foundation

class Stream {
    
    var broadcasterName: String!
    var streamTitle: String!
    var streamViewerCount: Double!
    var streamImage: UIImage?
    var streamImageUrl: String!
    
    init(name: String, title: String, viewerCount: Double, imageUrl: String) {
        self.broadcasterName = name
        self.streamTitle = title
        self.streamViewerCount = viewerCount
        self.streamImageUrl = imageUrl
    }
    
    func downloadStreamImage(completed: @escaping DownloadComplete) {
        request(self.streamImageUrl).responseData { (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.streamImage = image
                }
            }
            completed()
        }
    }
    
}
