//
//  MovieSection.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 18/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import RxDataSources


enum MovieSection {
	case itemsSection([MovieSectionItem])
}

enum MovieSectionItem {
	case items(ItemModel)
}


extension MovieSection: SectionModelType {
	
	typealias Item = MovieSectionItem
	
	var items: [Item] {
		switch self {
		case .itemsSection(let items):
			return items
		}
	}
	
	init(original: MovieSection, items: [Item]) {
		switch original {
		case .itemsSection:
			self = .itemsSection(items)
		}
	}
}
