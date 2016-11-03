//
//  main.swift
//  Perfect Weather Backend App Example
//
//  Created by Jonathan Guthrie on 2016-09-27.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
import PerfectLib
import PerfectCURL
import PerfectHTTP
import PerfectHTTPServer
import Foundation

private let apiCatchAll = "/**"
private let apiCurrentWeatherDefault = "/api/v1/current/"
private let apiCurrentWeatherStateCity = "/api/v1/current/{state}/{city}"
private let apiForecastDefault = "/api/v1/forecast/"
private let apiForecastStateCity = "/api/v1/forecast/{state}/{city}"

let server = HTTPServer()
var routes = Routes()

routes.add(method: .get, uris: [apiCurrentWeatherDefault, apiCurrentWeatherStateCity]) {
	request, response in

	let state = request.urlVariables["state"] ?? AppConfig.defaultState
	let city = request.urlVariables["city"] ?? AppConfig.defaultCity

	response.setHeader(.contentType, value: "application/json")
	response.appendBody(string: Weather.getCurrentWeather(location: "\(state)/\(city)"))
	response.completed()
}

routes.add(method: .get, uris: [apiForecastDefault, apiForecastStateCity]) {
	request, response in

	let state = request.urlVariables["state"] ?? AppConfig.defaultState
	let city = request.urlVariables["city"] ?? AppConfig.defaultCity

	response.setHeader(.contentType, value: "application/json")
	response.appendBody(string: Weather.getForecast(location: "\(state)/\(city)"))
	response.completed()
}

routes.add(method: .get, uris: [apiCatchAll]) { request, response in
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    //dateFormatter.locale = Locale("en_US_POSIX")
    let currentDate = dateFormatter.string(from: Date())
    
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: "Catch all EJE at: \(currentDate)")
    response.completed()
}

// Start Http Server for defined routes on configured port.
server.addRoutes(routes)
server.serverPort = UInt16(AppConfig.serverHttpPort)

do {
	try server.start()
}
catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
