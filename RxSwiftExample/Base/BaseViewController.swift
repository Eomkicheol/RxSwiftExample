//
//  BaseViewController.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 12/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
	
	// MARK: Initializing
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit {
		print(self)
	}
	
	
	// MARK: Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureUI()
	}
	
	
	// MARK: UI Properties
	
	// MARK: Func
	func configureUI() {
		
	}
	
}
