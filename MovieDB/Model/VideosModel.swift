//
//  VideosModel.swift
//  MovieDB
//
//  Created by Muhammet Taha Genc on 27.10.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import Foundation

public struct VideosModel: Decodable {
//    let id : Int
    let results : [resultsDict]
}

public struct resultsDict: Decodable {
    let key : String
    let name : String
    let site : String
    let type : String
}
