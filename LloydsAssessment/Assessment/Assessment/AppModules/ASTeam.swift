//
//  Movie.swift
//  TestAssessment
//
//  Created by Sreeshaj KP on 09/09/2022.
//

import Foundation

struct ASTeam: Decodable {
    var team_id: Int?
    var rating: Double?
    var wins: Int?
    var losses: Int?
    var last_match_time: Int64?
    var name: String?
    var tag: String?
    var logo_url: String?
}

//added for testing two objects
extension ASTeam: Equatable {}
