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
	
	// MARK: ViewMdoel Configure
	
	typealias ViewModel = MainViewModel
	
	var viewModel: MainViewModel!
	var disposedBag: DisposeBag = DisposeBag()
	
	// MARK: UI Properties
	
	let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
	
	lazy var  collectView: UICollectionView = {
		let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
		view.alwaysBounceVertical = true
		view.showsVerticalScrollIndicator = true
		view.backgroundColor = .red
		
		//cell
		//view.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
		
		//refresh
		view.refreshControl = UIRefreshControl()
		
		
		return view
	}()
	
	let titleName: UILabel = {
		let label = UILabel()
		return label
	}()
	
	// MARK: Initializing
	
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
	
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	
	override func configureUI() {
		
		navigationItem.title = "Home"
		navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.hidesBarsOnSwipe = true
		
		[collectView].forEach {
			self.view.addSubview($0)
		}
		
		self.collectView.snp.makeConstraints {
			$0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
			$0.left.right.bottom.equalToSuperview()
		}
	}
	
	// MARK: UIEventBinding
	
	func uiEventBinding() {
		self.rx.viewDidLoad
			.map { "marvel" }
			.bind(to: viewModel.info)
			.disposed(by: self.disposedBag)
	}
	
	// MARK: Rx UIBinding
	
	func uiStateBinding() {
		viewModel.infoAction
			.drive(onNext: {
				print($0)
			})
			.disposed(by: self.disposedBag)
	}
}
