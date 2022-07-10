//
//  WeatherModel.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let product, welcomeInit: String?
    let dataseries: [Datasery]?

    enum CodingKeys: String, CodingKey {
        case product
        case welcomeInit = "init"
        case dataseries
    }
}

// MARK: - Datasery
struct Datasery: Codable {
    let timepoint, cloudcover, liftedIndex: Int?
    let precType: PrecType?
    let precAmount, temp2M: Int?
    let rh2M: String?
    let wind10M: Wind10M?
    let weather: String?

    enum CodingKeys: String, CodingKey {
        case timepoint, cloudcover
        case liftedIndex = "lifted_index"
        case precType = "prec_type"
        case precAmount = "prec_amount"
        case temp2M = "temp2m"
        case rh2M = "rh2m"
        case wind10M = "wind10m"
        case weather
    }
}

enum PrecType: String, Codable {
    case none = "none"
}

// MARK: - Wind10M
struct Wind10M: Codable {
    let direction: Direction?
    let speed: Int?
}

enum Direction: String, Codable {
    case n = "N"
    case ne = "NE"
    case e = "E"
    case se = "SE"
    case s = "S"
    case sw = "SW"
    case w = "W"
    case nw = "NW"
}
