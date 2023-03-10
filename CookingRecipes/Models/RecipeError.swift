//
//  RecipeError.swift
//  CookingRecipes
//
//  Created by Nikita Zubov on 10.03.2023.
//

import Foundation

protocol LocalizedError: Error {
    var errorDescription: String { get }
}

public enum RecipeError: LocalizedError {
    
    var errorDescription: String {
        switch self {
        case .urlNotCreate: return "URL не создается"
        case .dataError: return "Ошибка с данными"
        case .decodeError: return "Ошибка в декодировании"
        case .internetConnectionLost: return "Не удалось установить соединение с сетью"
        }
    }
    
    case urlNotCreate
    case internetConnectionLost
    case dataError
    case decodeError
}
