//
//  HTTPManager.swift
//  
//
//  Created by Khatib Mahad H. on 8/3/21.
//

import Foundation
import Network

final class HTTPManager {
    static let shared: HTTPManager = HTTPManager()
    private let monitor:NWPathMonitor
    public var isOnline: Bool = false

    enum HTTPError: Error {
        case offline
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
    }
    
    init() {
        self.monitor = NWPathMonitor()
        self.startConnectivityMonitor()
    }

    private func startConnectivityMonitor() {
        self.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                self.isOnline = true
            } else {
                print("No connection.")
                self.isOnline = false
            }
            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    public func get(urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        if !self.isOnline {
            completionBlock(.failure(HTTPError.offline))
            return
        }

        guard let url = URL(string: urlString) else {
            completionBlock(.failure(HTTPError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HTTPError.invalidResponse(data, response)))
                    return
            }

            completionBlock(.success(responseData))
        }
        .resume()
    }
    
    func downloadImage(imageURLString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if !self.isOnline {
            completion(.failure(HTTPError.offline))
            return
        }
        
        get(urlString: imageURLString) { result in
                switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            case .success(let data):
                DispatchQueue.main.async() {
                    completion(.success(data))
                }
            }
        }
    }
}
