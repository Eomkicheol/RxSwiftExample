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

protocol mainViewModeType {
	
	//UIEvent
	var info: PublishRelay<String> { get }
	
	
	//UIState
	var infoAction: Observable<Int> { get }
}

final class MainViewModel: mainViewModeType {
	var info: PublishRelay<String> = PublishRelay()
	
	var infoAction: Observable<Int>
	
	init() {
		print("112324")
		infoAction = info			
			.flatMap { Service.shared.request(.search($0)).map(MovieModel.self)}
			.map { $0.display}
			.debug()
			.catchErrorJustReturn(0)
		
		
//			.asDriver(onErrorJustReturn: [])
	}
}
