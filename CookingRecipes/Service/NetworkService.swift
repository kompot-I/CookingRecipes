//
//  NetworkService.swift
//  CookingRecipes
//
//  Created by Nikita Zubov on 10.03.2023.
//

import Foundation


class NetworkService {
    
    static let shared = NetworkService()
    private init() { }
    
    private let baseURL = "https://api.spoonacular.com/recipes"
    //private let apiKey = "ec302cd3ae2e439b9558cc79d26c5efa"
    private let apiKey = "1d725eb876444268ae0f53d1bcbe8b44"
    
     
    /// запрос для списка популярных рецептов (массив)
    func fetchRecipesPopularity(completion: @escaping (Result<ResultData, Error>) -> Void) {
        let urlString = "\(baseURL)/complexSearch?apiKey=\(apiKey)&sort=popularity"
        performRequest(with: urlString, type: ResultData.self) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    /// создает ссылку для запроса
    private func createUrlString(from ids: [Int]) -> String {
        var idList = ""
        ids.forEach { id in
            idList += String(id) + ","
        }
        let urlString = "\(baseURL)/informationBulk?apiKey=\(apiKey)&ids=\(idList)"
        
        return urlString
    }
    
    
    /// делает запрос
    private func performRequest<T: Decodable>(with urlString: String, type: T.Type, completion: @escaping (Result<T, RecipeError>) -> Void) {
        let newUrl = urlString.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: newUrl) else {
            completion(.failure(.urlNotCreate))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            let statusCode = response.statusCode
            
            guard error == nil else {
                completion(.failure(.internetConnectionLost))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            do {
                if let decodedData = try? JSONDecoder().decode(type.self, from: data) {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(.decodeError))
                }
            }
        }
        /// Возобновляет выполнение задачи, если она приостановлена.
        task.resume()
    }
}
