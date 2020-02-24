//
//  MoviesModel.swift
//  MovieDB
//
//  Created by Muhammet Taha Genc on 14.10.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import Foundation

public struct MoviesModel : Decodable {
    let results : [MoviesResults]?
    let page : Int?
    let total_results : Int?
    let dates : MoviesDates?
    let total_pages : Int?
}

public struct MoviesResults : Decodable {
    let popularity : Double?
    let vote_count : Int?
    let video : Bool?
    let poster_path : String?
    let id : Int?
    let adult : Bool?
    let backdrop_path : String?
    let original_language : String?
    let original_title : String?
//    let genre_ids : [Int : String]
    let title : String?
    let vote_average : Double?
    let overview : String?
    let release_date : String?
}

//public struct MoviesGenreID : Decodable {
//
//}

public struct MoviesDates : Decodable {
    let maximum : String?
    let minimum : String?
}


