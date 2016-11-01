//
//  AppConfig.swift
//  Perfect-Weather
//
//  Created by Eric Elfner on 2016-11-01.
//
//

// This was created as a replacement for the ApplicationConfiguration.json file which made server
// deployments more difficult. Some of these should probably be loaded from the environment.
import Foundation

struct AppConfig {
    static let weatherUndergroundAPI_token = "d033e284ffe02f70"
    static let serverHttpPort = 8181
    static let defaultState = "CA"
    static let defaultCity = "San_Francisco"
    static let defaultStateCity = "\(defaultState)/\(defaultCity)"
}
