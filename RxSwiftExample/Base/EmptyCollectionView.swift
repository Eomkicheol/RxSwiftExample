//
//  EmptyCollectionView.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 15/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import Foundation
import UIKit

import SnapKit

class EmptyCollectionView: UIView {
	
	let emptyLabel: UILabel = {
		let view = UILabel()
		view.text = "검색된 조회 내용이 없습니다.!!!"
		view.textAlignment = NSTextAlignment.center
		view.font = UIFont.boldSystemFont(ofSize: 20)
		view.textColor = .red
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	 func configureUI() {
		[emptyLabel].forEach {
			self.addSubview($0)
		}
		
		emptyLabel.snp.makeConstraints {
			$0.center.equalToSuperview()
		}
	}
	
	
}
