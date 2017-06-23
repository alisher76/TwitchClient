//
//  Constants.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation

// Twitch API urls

let TWITCH_URL_TOP_GAMES = "https://api.twitch.tv/kraken/games/top?limit=50&client_id=mxdcbd0bp151snfpkswmwhg6op4wow"

let TWITCH_URL_STREAMS_BASE = "https://api.twitch.tv/kraken/streams/?game="

let TWITCH_URL_STREAMS_CLIENT_ID = "&client_id=mxdcbd0bp151snfpkswmwhg6op4wow"

let TWITCH_URL_STREAM_DEEP_LINK = "twitch://open?stream="

let TWITCH_URL_EMBED_BASE = "https://player.twitch.tv/?channel="

typealias DownloadComplete = () -> ()
