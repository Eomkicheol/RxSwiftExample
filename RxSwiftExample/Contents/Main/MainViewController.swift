//
//  MainViewController.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 11/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import SnapKit
import Moya

final class MainViewController: BaseViewController, BinderViewType {
	
	var viewModel: MainViewModel!
	var disposedBag: DisposeBag = DisposeBag()
	
	typealias ViewModel = MainViewModel
	
	
	func uiEventBinding() {
	
		viewModel.info
			.map { _ in "marvel" }
			.debug()
			.bind(to: viewModel.info)
			.disposed(by: self.disposedBag)

		
	}
	
	func uiStateBinding() {
		
		viewModel.infoAction
			.debug("321321")
			.subscribe(onNext: { [weak self] in
				print($0)
			})
		.disposed(by: self.disposedBag)

		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	
	init(viewModel: MainViewModel) {
		defer {
			self.viewModel = viewModel
			self.uiEventBinding()
			self.uiStateBinding()
		}
		
		super.init()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
