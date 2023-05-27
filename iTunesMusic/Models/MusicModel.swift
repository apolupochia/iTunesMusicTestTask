//
//  File.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)



import Foundation

// MARK: - MusicModel
struct MusicModel: Codable {
    let resultCount: Int
    var results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let kind: String
    let artistName : String
    let trackName : String

    let artworkUrl100: String?
    let releaseDate: String
}
