//
//  Service.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 11/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import SystemConfiguration

import Moya
import Alamofire
import Sniffer
import RxSwift



//네트워크 로깅
class DefaultAlamofireManger: Alamofire.SessionManager {
	
	static let sharedManager: DefaultAlamofireManger = {
		let configuration = URLSessionConfiguration.default
		Sniffer.enable(in: configuration)
		configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
		configuration.timeoutIntervalForRequest = 20
		configuration.timeoutIntervalForResource = 20
		configuration.requestCachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
		return DefaultAlamofireManger(configuration: configuration)
	}()
}


final class Service: ServiceType {
	
	//싱글톤 생성
	static let sharedInstance = Service()
	
	
	static var shared: Service {
		return sharedInstance
	}
	
	//moya provider
	private let provider: MoyaProvider<AppApi> = {
		let provider = MoyaProvider<AppApi>(endpointClosure: MoyaProvider.defaultEndpointMapping,
																				requestClosure: MoyaProvider<AppApi>.defaultRequestMapping,
																				stubClosure: MoyaProvider.neverStub,
																				callbackQueue: nil,
																				manager: DefaultAlamofireManger.sharedManager,
																				plugins: [],
																				trackInflights: false)
		return provider
	}()
	
	func request(_ api: AppApi) -> Observable<Response> {
		let ob = connectedToNetwork
			.flatMap { [weak self] flag -> Observable<Response> in
				if flag == true {
					guard let observer = self?.provider.rx.request(api).asObservable() else { return Observable.empty() }
					return observer
				} else {
					return Observable.error(NSError(domain: AppError.message.description, code: 0, userInfo: nil))
				}
		}
			.flatMap { value -> Observable<Response> in
				guard value.statusCode >= 200, value.statusCode < 300 else { return Observable.error(NSError(domain: AppError.message.description, code: 0, userInfo: nil))}
				return Observable.create({ observer in
					observer.onNext(value)
					return Disposables.create()
				})
		}
		return ob
	}
	
	//networking checked
	var connectedToNetwork: Observable<Bool> {
		return Observable.create({ observer -> Disposable in
			
			var zeroAddress = sockaddr_in()
			zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
			zeroAddress.sin_family = sa_family_t(AF_INET)
			
			guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
				$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
					SCNetworkReachabilityCreateWithAddress(nil, $0)
				}
				
			}) else { return Disposables.create() }
			
			
			var flags: SCNetworkReachabilityFlags = []
			
			if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
				observer.onNext(false)
				observer.onCompleted()
			}
			
			let isReachable = flags.contains(.reachable)
			let needsConnection = flags.contains(.connectionRequired)
			
			observer.onNext(isReachable && !needsConnection)
			observer.onCompleted()
			
			return Disposables.create()
			
		})
	}
}
