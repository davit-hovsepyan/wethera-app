//
//  Menager.swift
//  WeatherApp
//
//  Created by Davit Hovsepyan on 12.09.22.
//

import Foundation
import Alamofire

struct WeatherManager{
    
    private let API_KEY = "3e11c7f1c0eaf6e42b36b30a366deee9"
    
    func fetchWeather(byCity: String, completion: @escaping (Result<WeatherModel, Error>) -> Void){
        
        let query = byCity.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? byCity
        let path = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=metric"
        let urlString = String(format: path, query, API_KEY)
        
        AF.request(urlString).responseDecodable(of: WeatherData.self, queue: .main,  decoder: JSONDecoder()) { (response) in
            
            switch response.result{
            case .success(let weatherData):
                let model = weatherData.model
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
        
    }
}
