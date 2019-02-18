//
//  MainViewModel.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 11/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya

protocol MainViewModelInput: class {
	var movieSearch: PublishRelay<String> { get }
	var searchErrorMessage: PublishRelay<String> { get }
	
}

protocol MainviewModelOutput: class {
	var searchErrorMessageAction: Driver<String>? { get }
	var movieSearchAction: Driver<[MovieSection]> { get }
}

final class MainViewModel: MainViewModelInput, MainviewModelOutput {
	
	var movieSearch: PublishRelay<String> = PublishRelay()
	var movieSearchAction: Driver<[MovieSection]>
	
	var searchErrorMessage: PublishRelay<String> = PublishRelay()
	var searchErrorMessageAction: Driver<String>?
	
	init() {
		
	movieSearchAction	= movieSearch
			.flatMap { Service.shared.request(.search($0)).map(MovieModel.self)}
			.map { sectionItems -> [MovieSectionItem] in
				return sectionItems.items.map({ item -> MovieSectionItem in
					return MovieSectionItem.items(item)
				})
			}
			.map { sections -> [MovieSection] in
				return [MovieSection.itemsSection(sections)]
		}
		.asDriver(onErrorJustReturn: [])
		
		searchErrorMessageAction = searchErrorMessage
			.asDriver(onErrorRecover: { [weak self] message -> Driver<String> in
				self?.searchErrorMessage.accept(message.localizedDescription)
				return Driver.empty()//complete ? empty : Driver.just
			})
		
		
		
	}
}
