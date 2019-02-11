//
//  MovieModel.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 11/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
	var lastBuildDate: String
	var total: Int
	var start: Int
	var display: Int
	var items: [ItemModel]
}

struct ItemModel: Codable {
	var title: String
	var link: String
	var image: String
	var subtitle: String
	var pubDate: String
	var director: String
	var actor: String
	var userRating: String
}
