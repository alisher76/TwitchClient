//
//  ChannelViewController.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/23/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit
import WebKit

class ChannelViewController: UIViewController {
    
    var stream: Stream!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
        
        let urlString = TWITCH_URL_EMBED_BASE + stream.broadcasterName
        print(urlString)
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
