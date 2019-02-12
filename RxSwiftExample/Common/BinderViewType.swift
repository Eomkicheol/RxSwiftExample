//
//  BinderViewType.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 12/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import RxSwift

public protocol BinderViewType: class {
	associatedtype ViewModel
	var viewModel: ViewModel! { get set }
	var disposedBag: DisposeBag {get set}
	func uiEventBinding()
	func uiStateBinding()
}
