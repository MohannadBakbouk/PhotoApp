//
//  Constant.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//

import Foundation

enum Api : String {
    case url = "https://www.flickr.com/services/rest/"
    case key = "d17378e37e555ebef55ab86c4180e8dc"
    case format = "json"
    case accept = "application/json; charset=utf-8"
}

enum Icons : String {
    case checkmark = "checkmark.circle.fill"
    case xmark = "xmark.circle.fill"
    case wifiProblem = "exclamationmark.icloud.fill"
}
enum Colors : String {
    case flatGreen = "#27ae60"
    case flatRed = "#e74c3c"
    case flatdark = "#34495e"
}
