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
	var info: PublishRelay<String> { get }
}

protocol MainviewModelOutput: class {
	var infoAction: Driver<[String]> { get }
	
}

final class MainViewModel: MainViewModelInput, MainviewModelOutput {
	var info: PublishRelay<String> = PublishRelay()
	var infoAction: Driver<[String]>
	
	init() {
		infoAction = info
			.flatMap { Service.shared.request(.search($0)).map(MovieModel.self)}
			.map({ value -> [String] in
				return value.items.map({ aa -> String in
					return "\(aa.actor), \(aa.title) "
				})
			})
			.asDriver(onErrorJustReturn: [])
	}
}
