//
//  RandomUser+ResponseData.swift
//  Alamofire_Tutorial_SwiftUI
//
//  Created by SeongMinK on 2021/12/18.
//

import Foundation

struct RandomUser: Codable, Identifiable, CustomStringConvertible {
    var id = UUID()
    var name: Name
    var photo: Photo
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case photo = "picture"
    }
    
    static func getDummy() -> Self {
        print(#fileID, #function, "called")
        return RandomUser(name: Name.getDummy(), photo: Photo.getDummy())
    }
    
    var profileImgUrl: URL {
        get {
            URL(string: photo.medium)!
        }
    }
    
    var description: String {
        return name.description
    }
}

struct Name: Codable, CustomStringConvertible {
    var title: String
    var first: String
    var last: String
    
    var description: String {
        return "[\(title)] \(last) \(first)"
    }
    
    static func getDummy() -> Self {
        print(#fileID, #function, "called")
        return Name(title: "대학생", first: "SeongMin", last: "Kim")
    }
}

struct Photo: Codable {
    var large: String
    var medium: String
    var thumbnail: String
    static func getDummy() -> Self {
        print(#fileID, #function, "called")
        return Photo(large: "https://randomuser.me/api/portraits/men/75.jpg",
                     medium: "https://randomuser.me/api/portraits/med/men/75.jpg",
                     thumbnail: "https://randomuser.me/api/portraits/thumb/men/75.jpg")
    }
}

struct Info: Codable {
    var seed: String
    var resultsCount: Int
    var page: Int
    var version: String
    private enum CodingKeys: String, CodingKey {
        case seed = "seed"
        case resultsCount = "results"
        case page = "page"
        case version = "version"
    }
}

struct RandomUserResponse: Codable, CustomStringConvertible {
    var results: [RandomUser]
    var info: Info
    
    var description: String {
        return "results.count: \(results.count) / info: \(info.seed)"
    }
}
