//
//  Services.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import Foundation

class Services {    
    class var shared: Services {
        struct Static {
            static let instance = Services()
        }
        return Static.instance
    }
    enum HTTPError: Error {
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
    }
    
    func getWeatherFrom(lon: String, lat: String,completion : @escaping (Result<Weather, Error>)->()) {
        let session = URLSession.shared
        let urlString: String = "https://www.7timer.info/bin/api.pl?lon=\(lon)&lat=\(lat)&product=civil&output=json"
        guard let url = URL(string: urlString) else { return }
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let task: URLSessionTask = session.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else { return }
                guard
                    let responseData = data,
                    let httpResponse = response as? HTTPURLResponse,
                    200 ..< 300 ~= httpResponse.statusCode else {
                    completion(.failure(HTTPError.invalidResponse(data, response)))
                    return
                }
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let weather = try decoder.decode(Weather.self, from: responseData)
                    completion(.success(weather))
                } catch _ {
                    completion(.failure(HTTPError.invalidResponse(data, response)))
                }
            }
        }
        task.resume()
    }
}
