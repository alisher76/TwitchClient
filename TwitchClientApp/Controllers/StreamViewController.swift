//
//  StreamViewController.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class StreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var streamsTableView: UITableView!
    
    
    var game: Game! {
        didSet {
            downLoadStreams()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
         title = "\(game.gameName!)"
        
        streamsTableView.delegate = self
        streamsTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downLoadStreams()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        StreamDataService.instance.removeAllStreams()
    }
    
    // MARK: UItableViewDatasurce
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StreamDataService.instance.streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let streamCell = tableView.dequeueReusableCell(withIdentifier: "StreamCell") as! StreamTableViewCell
        
        let stream = StreamDataService.instance.streams[indexPath.row]
        streamCell.configureCell(stream)
        print(StreamDataService.instance.streams.count)
        
        return streamCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (streamsTableView.bounds.width / 16) * 9
    }
    
   func downLoadStreams() {
     StreamDataService.instance.downloadStreamsForGame(game) {
            for stream in StreamDataService.instance.streams {
                stream.downloadStreamImage {
                    DispatchQueue.main.async {
                        self.streamsTableView.reloadData()
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stream = StreamDataService.instance.streams[indexPath.row]
        openStream(stream)
    }
    
    func openStream(_ stream: Stream) {
        let alert = UIAlertController(title: "Open stream in VirerTwitch or in official Twitch app?", message: "Official Twitch app must be installed for latter option.", preferredStyle: .alert)
        
        let openInVirerTwitchAction = UIAlertAction(title: "VirerTwitch", style: .default) { (action) in
            self.performSegue(withIdentifier: "showChannel", sender: stream)
        }
        
        let openinTwitchAppAction = UIAlertAction(title: "Twitch", style: .default) { (action) in
            self.openStreamInTwitchApp(stream)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
        
        alert.addAction(openInVirerTwitchAction)
        alert.addAction(openinTwitchAppAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChannel" {
            if let channelVC = segue.destination as? ChannelViewController {
                if let stream = sender as? Stream {
                    channelVC.stream = stream
                }
            }
        }
    }
    
    func openStreamInTwitchApp(_ stream: Stream) {
        let streamString = TWITCH_URL_STREAM_DEEP_LINK + stream.broadcasterName
        
        if let streamUrl = URL(string: streamString) {
            if UIApplication.shared.canOpenURL(streamUrl) {
                UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let stream = StreamDataService.instance.streams[indexPath.row]
        
        openStream(stream)
    }
    
}
