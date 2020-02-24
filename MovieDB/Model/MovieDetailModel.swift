//
//  MovieDetailModel.swift
//  MovieDB
//
//  Created by Muhammet Taha Genc on 25.10.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import Foundation

public struct MovieDetailModel : Decodable {
    let adult : Bool?
    let backdrop_path : String?
//    let belongs_to_collection : belongsToCollection
    let budget : Int?
    let genres : [genres]
    let homepage : String?
    let id : Int?
    let imdb_id : String?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
//    let production_companies : [productionCompanies]
//    let production_countries : [productionCountries]
    let release_date : String?
    let revenue : Int?
    let runtime : Int?
//    let spoken_languages : [spokenLanguages]
    let status : String?
    let tagline : String?
    let title : String?
    let video : Bool?
    let vote_average : Double?
    let vote_count : Int?
}

public struct genres : Decodable {
    let id : Int?
    let name : String?
}

//public struct productionCompanies : Decodable {
//    let id : Int?
//    let logo_path : String?
//    let name : String?
//    let origin_country : String?
//}
//
//public struct productionCountries : Decodable {
//    let iso_3166_1 : String?
//    let name : String?
//}
//
//public struct spokenLanguages : Decodable {
//    let iso_639_1 : String?
//    let name : String?
//}
//public struct belongsToCollection : Decodable {
//    let id : Int?
//    let name : String?
//    let poster_path : String?
//    let backdrop_path : String?
//}
