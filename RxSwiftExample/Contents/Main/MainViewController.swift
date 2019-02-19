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
import RxDataSources

typealias MainViewSection = RxCollectionViewSectionedReloadDataSource<MovieSection>

final class MainViewController: BaseViewController, BinderViewType {
	
	// MARK: ViewMdoel Configure
	
	typealias ViewModel = MainViewModel
	
	var viewModel: MainViewModel!
	var disposedBag: DisposeBag = DisposeBag()
	
	// MARK: UI Properties
	
	lazy var dataSource: MainViewSection = MainViewSection(configureCell: { _, collectView, indexPath, items -> UICollectionViewCell in
		switch items {
		case .items(let items):
			let cell = collectView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath)
			
			guard let movieCell = cell as? MovieCollectionViewCell else { return cell }
			
			
			movieCell.setEntity(value: items)
			
			return movieCell
		}
	}, configureSupplementaryView: { _, collectView, kind, indexPath -> UICollectionReusableView in
		if kind == UICollectionView.elementKindSectionFooter {
			let view = collectView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
			return view
		}
		
		return UICollectionReusableView()
		
	})
	
	let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
	
	lazy var collectView: UICollectionView = {
		let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
		view.alwaysBounceVertical = true
		view.showsVerticalScrollIndicator = true
		view.backgroundColor = .clear
		view.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
		view.keyboardDismissMode = .onDrag
		
		
		//cell
		view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
		view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
		
		
		return view
	}()
	
	lazy var searchBar: UISearchBar = {
		let view = UISearchBar()
		view.placeholder = "검색어를 입력해 주세요"
		view.text = "신과 함께"
		view.searchBarStyle = .prominent
		view.autocorrectionType = .no
		view.autocapitalizationType = .none
		return view
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
		self.navigationSetting()
		self.view.backgroundColor = UIColor(white: 0.9, alpha: 1)
		
		[searchBar, collectView].forEach {
			self.view.addSubview($0)
		}
		
		self.searchBar.snp.makeConstraints {
			$0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
			$0.left.right.equalToSuperview()
		}
		
		self.collectView.snp.makeConstraints {
			$0.top.equalTo(searchBar.snp.bottom).offset(5)
			$0.left.right.bottom.equalToSuperview()
		}
	}
	
	func navigationSetting() {
		navigationItem.title = "Home"
		navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.hidesBarsOnSwipe = true
	}
	
	// MARK: UIEventBinding
	
	func uiEventBinding() {
		
		self.searchBar.rx.searchButtonClicked
			.map { [weak self] _ in
				self?.searchBar.text ?? ""
			}
			.bind(to: viewModel.movieSearch )
			.disposed(by: self.disposedBag)
		
		//		collectView.rx.itemSelected
		//			.map { $0 }
		//			.bind(to: viewModel.detailItems )
		//			.disposed(by: self.disposedBag)
	}
	
	// MARK: Rx UIBinding
	
	func uiStateBinding() {
		
		self.collectView.rx.setDelegate(self).disposed(by: self.disposedBag)
		
		viewModel.movieSearchAction
			.do(onNext: { [weak self] _ in
				UIView.animate(withDuration: 0.75, animations: {
					self?.searchBar.resignFirstResponder()
					self?.searchBar.text  = ""
				})
			})
			.delay(0.5)
			.drive(collectView.rx.items(dataSource: dataSource))
			.disposed(by: self.disposedBag)
		
	}
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		switch dataSource[indexPath] {
		case .items:
			return MovieCollectionViewCell.cellHeight(width: collectView.bounds.width)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		switch dataSource[section] {
		case .itemsSection:
			return .init(top: 10, left: 0, bottom: 0, right: 0)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 1.5
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		switch dataSource[section] {
		case .itemsSection:
			return .init(width: collectView.bounds.width, height: 100)
			
		}
	}
}
