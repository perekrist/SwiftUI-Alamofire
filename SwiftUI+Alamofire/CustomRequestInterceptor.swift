//
//  CustomRequestInterceptor.swift
//  SwiftUI+Alamofire
//
//  Created by Кристина Перегудова on 26.10.2022.
//

import Foundation
import Alamofire

class CustomRequestInterceptor: RequestInterceptor {
  private let retryLimit = 5
  private let retryDelay: TimeInterval = 10
  
  func adapt(_ urlRequest: URLRequest,
             for session: Session,
             completion: @escaping (Result<URLRequest, Error>) -> Void) {
    var urlRequest = urlRequest
    if let token = TokenManager.shared.fetchAccessToken() {
      urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    completion(.success(urlRequest))
  }
  
  func retry(_ request: Request,
             for session: Session,
             dueTo error: Error,
             completion: @escaping (RetryResult) -> Void) {
    guard let statusCode = (request.task?.response as? HTTPURLResponse)?.statusCode else {
      completion(.doNotRetry)
      return
    }
    
    switch statusCode {
    case 401:
      refreshToken { [weak self] in
        guard let self,
              request.retryCount < self.retryLimit else { return }
        completion(.retryWithDelay(self.retryDelay))
      }
    case (500...599):
      guard request.retryCount < retryLimit else { return }
      completion(.retryWithDelay(retryDelay))
    default:
      completion(.doNotRetry)
    }
  }
  
  private func refreshToken(completion: @escaping (() -> Void)) {
    // TODO: refresh token
    print("Refreshing token...")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      TokenManager.shared.token = UUID().uuidString
      completion()
    }
  }
}
