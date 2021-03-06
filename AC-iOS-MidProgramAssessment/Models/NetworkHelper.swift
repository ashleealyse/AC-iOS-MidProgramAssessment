//
//  NetworkHelper.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Ashlee Krammer on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with urlRequest: URLRequest, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((AppError) -> Void)) {
        self.urlSession.dataTask(with: urlRequest){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
                guard (response as? HTTPURLResponse) != nil else{
                    errorHandler(AppError.badStatusCode)
                    return
                }
                
                if let error = error{
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet{
                        errorHandler(AppError.noInternetConnection)
                    }else{
                        errorHandler(AppError.other(rawError: error))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}








//
//class NetworkHelper {
//    private init() {}
//    static let manager = NetworkHelper()
//
//    let session = URLSession(configuration: URLSessionConfiguration.default)
//    func performDataTask(with request: URLRequest, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((AppError) -> Void)) {
//        self.session.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
//            DispatchQueue.main.async {
//                guard let data = data else {
//                    errorHandler(AppError.noDataReceived)
//                    return
//                }
//                guard (response as? HTTPURLResponse) != nil else{
//                    errorHandler(AppError.badStatusCode)
//                    return
//                }
//
//                if let error = error{
//                    let error = error as NSError
//                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet{
//                        errorHandler(AppError.noInternetConnection)
//                    }else{
//                        errorHandler(AppError.other(rawError: error))
//                    }
//                }
//                completionHandler(data)
//            }
//            }.resume()
//    }
//
//
//
//
//
//}

