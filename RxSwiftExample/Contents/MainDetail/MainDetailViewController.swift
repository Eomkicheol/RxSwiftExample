//
//  MainDetailViewController.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 19/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//
import RxCocoa
import RxSwift
import RxViewController

final class MainDetailViewController: BaseViewController, BinderViewType {
	
	var viewModel: MainDetailViewModel!
	
	var disposedBag: DisposeBag = DisposeBag()
	
	typealias ViewModel = MainDetailViewModel
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func configureUI() {
		
	}
	
	func uiEventBinding() {}
	
	func uiStateBinding() {}
}
