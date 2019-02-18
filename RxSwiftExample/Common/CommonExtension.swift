//
//  CommonExtension.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 18/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionReusableView {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}

extension String {
	var removeHTMLTag: String {
		return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
	}
	
	var replacingComma: String {
		return self.replacingOccurrences(of: "|", with: ",", options: [.literal], range: nil)
		
	}
}
