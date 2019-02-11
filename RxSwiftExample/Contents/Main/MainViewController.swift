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

final class MainViewController: UIViewController {
	
	let disposed: DisposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configure(keyword: "marvel")
		
	}
	
	func configure(keyword: String) {
			Observable.just(keyword)
				.flatMap { keyword -> Observable<MovieModel> in
					return Service.shared.request(.search(keyword)).map(MovieModel.self)
				}
				.map { ($0.items, $0.start)}
				.debug()
				.subscribe(onNext: { [weak self] in
					print($0.0)
					}, onError: {
						print($0.localizedDescription)
				})
		.disposed(by: self.disposed)
		
		}
}
