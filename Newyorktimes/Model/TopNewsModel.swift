//
//  TopNewsModel.swift
//  Newyorktimes
//
//  Created by omair khan on 21/11/2021.
//

import Foundation

public struct TopStoriesResponse : Codable {
    let results : [Results]
}

public struct Results : Codable {
    
    let title : String
    let abstract : String
    let published_date : Date
    let url : String
    let multimedia : [Media]
}

public struct Media : Codable {
    let url : String
}
