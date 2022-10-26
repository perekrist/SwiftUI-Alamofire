//
//  ContentViewModel.swift
//  SwiftUI+Alamofire
//
//  Created by Кристина Перегудова on 26.10.2022.
//

import SwiftUI
import Alamofire

/// API: https://wizard-world-api.herokuapp.com/swagger/index.html

class ContentViewModel: ObservableObject {
  @Published var elixirs: [Elixir] = []
  
  private let baseURL = "https://wizard-world-api.herokuapp.com"
  private let interceptor = CustomRequestInterceptor()
  
  func loadElixirs() {
    let url = baseURL + "/Elixirs"
    
    var headers: HTTPHeaders = [:]
    if let token = TokenManager.shared.fetchAccessToken() {
      headers["Authorization"] = "Bearer " + token
    }
    
    AF.request(url,
               method: .get,
               headers: headers).responseData { response in
      if let request = response.request {
        print("Request:", request)
      }
      if let statusCode = response.response?.statusCode {
        print("Status Code:", statusCode)
      }
      switch response.result {
      case .success(let data):
        do {
          let decodedData = try JSONDecoder().decode([Elixir].self, from: data)
          self.elixirs = decodedData
        } catch(let error) {
          // TODO: catch decode error
          print(error.localizedDescription)
          return
        }
      case .failure(let error):
        // TODO: catch error
        print(error.localizedDescription)
        return
      }
    }
  }
}
