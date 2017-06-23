//
//  StreamTableViewCell.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class StreamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var streamImageView: UIImageView!
    @IBOutlet weak var broadcasterName: UILabel!
    @IBOutlet weak var streamTitle: UILabel!
    @IBOutlet weak var streamViewers: UILabel!
    
    
    func configureCell(_ stream: Stream) {
        broadcasterName.text = stream.broadcasterName
        streamTitle.text = stream.streamTitle
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        streamViewers.text = "\(formatter.string(from: NSNumber(value: stream.streamViewerCount))!) viewers"
        
        if stream.streamImage != nil {
            streamImageView.image = stream.streamImage
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
