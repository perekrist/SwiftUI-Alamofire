//
//  Elixir.swift
//  SwiftUI+Alamofire
//
//  Created by Кристина Перегудова on 26.10.2022.
//

import Foundation

struct Elixir: Identifiable, Codable {
  enum CodingKeys: String, CodingKey {
    case id, title = "name"
  }
  
  let id: String
  let title: String
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.title = try container.decode(String.self, forKey: .title)
  }
}
