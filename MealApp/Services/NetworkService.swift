//
//  NetworkService.swift
//  MealApp
//
//  Created by Dmitry Kononov on 19.02.25.
//

import UIKit
import Combine

final class NetworkService {
    
    private let host = URL(string: "https://www.themealdb.com/api/json/v1/1/")!
    
    func getRandomMeal() -> AnyPublisher<Meal?, Error> {
        return URLSession.shared.dataTaskPublisher(for: host.appending(path: "random.php"))
            .tryMap { element in
                guard let responce = element.response as? HTTPURLResponse, (200...299).contains(responce.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: MealResponse.self, decoder: JSONDecoder())
            .map { $0.meals?.first }
            .eraseToAnyPublisher()
    }
    
    func getImage(for url: String) -> AnyPublisher<UIImage?, Error> {
        return Future<UIImage?, Error> { result in
            
            guard let url = URL(string: url) else {
                result(.failure(URLError(.badURL)))
                return
            }
            
            DispatchQueue(label: "image_downloader").async {
                guard
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data)
                else {
                    result(.failure(NSError(domain: "image_downloader", code: 1, userInfo: nil)))
                    return
                }
                result(.success(image))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getMeals(by letter: String) -> AnyPublisher<[Meal], Error> {
        return URLSession.shared.dataTaskPublisher(
            for: host.appending(
                path: "search.php"
            ).appending(
                queryItems: [.init(name: "f", value: letter)]
            )
        )
        .tryMap({ element in
            guard let response = element.response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                throw URLError(.badServerResponse)
            }
            return element.data
        })
        .decode(type: MealResponse.self, decoder: JSONDecoder())
        .map { $0.meals ?? [] }
        .eraseToAnyPublisher()
    }
}
