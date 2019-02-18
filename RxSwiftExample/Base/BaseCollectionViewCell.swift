//
//  BaseCollectionViewCell.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 13/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	func configureUI() {}
	
	
}
