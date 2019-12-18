//
//  ITunesApp.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

public struct ITunesApp: Codable {
    
    public typealias Bytes = Int
    
    public let appName: String
    public let appUrl: String?
    public let company: String?
    public let companyUrl: String?
    public let appDescription: String?
    public let averageRating: Float?
    public let averageRatingForCurrentVersion: Float?
    public let size: Bytes?
    public let iconUrl: String?
    public let screenshotUrls: [String]
    
    public let version: String?
    public let releaseNotes: String?
    public let releaseDate: Date?
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case appName = "trackName"
        case appUrl = "artistViewUrl"
        case company = "sellerName"
        case companyUrl = "sellerUrl"
        case appDescription = "description"
        case averageRating = "averageUserRating"
        case averageRatingForCurrentVersion = "averageUserRatingForCurrentVersion"
        case size = "fileSizeBytes"
        case iconUrl = "artworkUrl512"
        case screenshotUrls = "screenshotUrls"
        
        case version
        case releaseNotes
        case releaseDate
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appName = try container.decode(String.self, forKey: .appName)
        self.appUrl = try? container.decode(String.self, forKey: .appUrl)
        self.company = try? container.decode(String.self, forKey: .company)
        self.companyUrl = try? container.decode(String.self, forKey: .companyUrl)
        self.appDescription = try? container.decode(String.self, forKey: .appDescription)
        self.averageRating = try? container.decode(Float.self, forKey: .averageRating)
        self.averageRatingForCurrentVersion = try? container.decode(Float.self, forKey: .averageRatingForCurrentVersion)
        self.size = (try? container.decode(String.self, forKey: .size)) >>- { Bytes($0) }
        self.iconUrl = try? container.decode(String.self, forKey: .iconUrl)
        self.screenshotUrls = (try? container.decode([String].self, forKey: .screenshotUrls)) ?? []
        
        self.version = try? container.decode(String.self, forKey: .version)
        self.releaseNotes = try? container.decode(String.self, forKey: .releaseNotes)
        self.releaseDate = try? container.decode(Date.self, forKey: .releaseDate)
    }
    
    // MARK: - Init
    
    internal init(appName: String,
                  appUrl: String?,
                  company: String?,
                  companyUrl: String?,
                  appDescription: String?,
                  averageRating: Float?,
                  averageRatingForCurrentVersion: Float?,
                  size: Bytes?,
                  iconUrl: String?,
                  screenshotUrls: [String],
                  version: String?,
                  releaseNotes: String?,
                  releaseDate: Date?) {
        self.appName = appName
        self.appUrl = appUrl
        self.company = company
        self.companyUrl = companyUrl
        self.appDescription = appDescription
        self.averageRating = averageRating
        self.averageRatingForCurrentVersion = averageRatingForCurrentVersion
        self.size = size
        self.iconUrl = iconUrl
        self.screenshotUrls = screenshotUrls
        
        self.version = version
        self.releaseNotes = releaseNotes
        self.releaseDate = releaseDate
    }
}

/*
 https://itunes.apple.com/search?term=music&country=RU&media=software

 "trackCensoredName":"Радио музыкальный",
 "languageCodesISO2A":["EN"],
 --"fileSizeBytes":"142394368",
 --"sellerUrl":"https://appysky.wordpress.com",
 "contentAdvisoryRating":"4+",
 --"averageUserRatingForCurrentVersion":4.5,
 "userRatingCountForCurrentVersion":81,
 "trackViewUrl":"https://apps.apple.com/ru/app/...",
 "trackContentRating":"4+",
 --"sellerName":"Luc Breton",
 "minimumOsVersion":"9.0",
 "currentVersionReleaseDate":"2019-10-04T23:30:16Z",
 "trackId":1116648839,
 --"trackName":"Радио музыкальный",
 ----------"releaseDate":"2016-09-02T04:15:48Z",
 "primaryGenreId":6011,
 "formattedPrice":"Бесплатно",
 ----------"releaseNotes":"√ UI Optimisations",
 "isVppDeviceBasedLicensingEnabled":true,
 "primaryGenreName":"Music",
 "genreIds":["6011", "6016"],
 "currency":"RUB",
 ----------"version":"4.0.3",
 "wrapperType":"software",
 "artistId":976539506,
 "artistName":"Luc Breton",
 "genres":["Музыка", "Развлечения"],
 "price":0.00,
 --"description":"√ Discover Music on a collection of Live Radio station broadcasts...",
 "bundleId":"com.luc.audiocloud",
 --"averageUserRating":4.5,
 "userRatingCount":296,
 --"artistViewUrl":"https://apps.apple.com/ru/developer/yandex-llc/id308094652?uo=4",
 --"artworkUrl512":"https://is2-ssl.mzstatic.com,
 --"screenshotUrls":[]
 */
