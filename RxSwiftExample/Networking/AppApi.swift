//
//  AppApi.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 11/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import Moya


enum AppApi {
	case search(String)
}

enum AppError {
	case message
}

extension AppApi: TargetType {
	
	var baseURL: URL {
		return URL(string: "https://openapi.naver.com/v1/search")!
	}
	
	var path: String {
		switch self {
			
		case .search:
			return "/movie.json"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .search:
			return .get
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .search:
			return .requestParameters(parameters: parameters!, encoding: parametersEncoding)
		}
	}
	
	var parameters: [String: Any]? {
		switch self {
		case .search(let movieName):
			return ["query": movieName]
		}
	}
	
	var parametersEncoding: ParameterEncoding {
		switch self {
		case .search:
			return URLEncoding.queryString
		}
	}
	
	var headers: [String: String]? {
		return [
						"X-Naver-Client-Id": "2Ta_hEjwyho6ObF6l038",
						"X-Naver-Client-Secret": "SUGRK1ZxUq"]
	}
}


extension AppError: CustomStringConvertible {
	var description: String {
		switch self {
		case .message:
			return "통신 실패!!!!!!!"
		}
	}
}
