//
//  NetworkService.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation

protocol NetworkService{
  func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager: NetworkService {
  static let shared = NetworkManager()
  private let baseURL = "https://swapi.dev/api"
  
  func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
    print("Fetching data from endpoint: \(endpoint)")
    guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
      print("Invalid URL")
      return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("Network error: \(error.localizedDescription)")
        completion(.failure(error))
      } else if let data = data {
        if let httpResponse = response as? HTTPURLResponse {
          print("HTTP Status Code: \(httpResponse.statusCode)")
        }
        do {
          let decodedData = try JSONDecoder().decode(T.self, from: data)
          completion(.success(decodedData))
        } catch {
          print("Decoding error: \(error.localizedDescription)")
          completion(.failure(error))
        }
      }
    }.resume()
  }
}

