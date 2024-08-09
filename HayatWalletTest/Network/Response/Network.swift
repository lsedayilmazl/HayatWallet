import Foundation
import UIKit


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case other(Error)
    case httpError(statusCode: Int)
    case unknownError
}

class Network {
    static let shared = Network()
    private init() {}
    
    
    func loginControl(userName: String, password: String, completion: @escaping (Result<LoginInfo,NetworkError>) -> Void) {
        
        let json: [String: Any] = [
            "userName": userName,
            "password": password,
            
        ]
        
        // URL ve istek yapılandırması
        guard let url = URL(string: "https://staging-api.cusp.link/User/signin") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error Serializing JSON: \(error.localizedDescription)")
            completion(.failure(.decodingError))
            return
        }
        
        // Ağ isteği yapılıyor
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network request error: \(error.localizedDescription)")
                completion(.failure(.other(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("No data received from server")
                completion(.failure(.noData))
                return
            }
            
            do {
                // JSON verisi `LoginInfo` modeline dönüştürülüyor
                let loginInfo = try JSONDecoder().decode(LoginInfo.self, from: data)
                completion(.success(loginInfo))
                // Başarı durumunda token'ı kaydediyoruz
                if let token = loginInfo.item?.token {
                    Transaction.shared.saveToken(token: token)
                    Transaction.shared.saveUsername(username: userName)
                                                        }
            } catch {
                print("JSON Decode Error: \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}


