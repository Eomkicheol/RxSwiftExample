//
//  MainDeatilViewModel.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 19/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import RxSwift
import RxCocoa

protocol MainDetailViewModelInput: class {
	var detailInfo: PublishRelay<String> { get }
	var errorMessage: PublishRelay<String> { get }
}

protocol MainDetailViewModelOutput: class {
	var detailInfoAction: Driver<String> { get }
	var errorMessageAction: Driver<String>? { get }
}

protocol MainDetailViewModelBinder: MainDetailViewModelInput, MainDetailViewModelOutput {}

final class MainDetailViewModel: MainDetailViewModelBinder {
	var detailInfo: PublishRelay<String> = PublishRelay()
	var errorMessage: PublishRelay<String> = PublishRelay()
	
	var detailInfoAction: Driver<String>
	var errorMessageAction: Driver<String>?
	
	init() {
		
		detailInfoAction = detailInfo
			.asDriver(onErrorJustReturn: "")
		
		
		errorMessageAction = errorMessage
			.asDriver(onErrorRecover: { [weak self] message -> Driver<String> in
				self?.errorMessage.accept(message.localizedDescription)
				return Driver.empty()
			})
	}
}
