//
//  ServiceType.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 11/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import UIKit
import RxSwift
import Moya

protocol ServiceType {
	func request(_ api: AppApi) -> Observable<Response>
}
