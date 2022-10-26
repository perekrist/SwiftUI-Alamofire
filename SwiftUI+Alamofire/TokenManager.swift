//
//  TokenManager.swift
//  SwiftUI+Alamofire
//
//  Created by Кристина Перегудова on 26.10.2022.
//

import Foundation

class TokenManager {
  static let shared = TokenManager()
  
  var token: String?
  
  func fetchAccessToken() -> String? {
    token
  }
}

