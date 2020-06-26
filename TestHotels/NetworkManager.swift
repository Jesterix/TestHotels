//
//  NetworkManager.swift
//  TestHotels
//
//  Created by Георгий Хайденко on 25.06.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import Foundation

class NetworkManager {
    var baseURL = URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master")
    var baseImageURL = URL(string: "https://github.com/iMofas/ios-android-test/raw/master")

    enum DataType: String {
        case json = ".json"
        case jpg = ".jpg"
    }

    enum URLError: Error {
        case invalidURL
    }

    func makeURL(
        for object: String = "0777",
        dataType: DataType = .json) throws -> URL
    {
        var baseUrl: URL? {
            switch dataType {
            case .json:
                return baseURL
            case .jpg:
                return baseImageURL
            }
        }

        guard var url = baseUrl else {
            throw URLError.invalidURL
        }

        url.appendPathComponent(object + dataType.rawValue)

        return url
    }

    func getHotelListData(
        completion: @escaping (Result<[Hotel], Error>) -> Void) {

        do {
            let url = try makeURL()
            print(url)
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completion(.failure(RequestError.invalidData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result: [Hotel] = try decoder.decode(
                        [Hotel].self,
                        from: data)
                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(RequestError.invalidJson))
                }

            }.resume()
        } catch let error {
            completion(.failure(error))
        }
    }
}

enum RequestError: Swift.Error, CustomStringConvertible {
    case invalidData
    case invalidJson

    public var description: String {
        switch self {
        case .invalidData: return "invalid data"
        case .invalidJson: return "invalid json"
        }
    }
}
