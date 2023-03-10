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
    
    
}
