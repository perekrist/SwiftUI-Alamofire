//
//  ContentView.swift
//  SwiftUI+Alamofire
//
//  Created by Кристина Перегудова on 26.10.2022.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject private var viewModel = ContentViewModel()
  
  var body: some View {
    ZStack {
      List(viewModel.elixirs) { elixir in
        Text(elixir.title)
      }
      if viewModel.elixirs.isEmpty {
        ProgressView()
      }
    }.onAppear {
      viewModel.loadElixirs()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
