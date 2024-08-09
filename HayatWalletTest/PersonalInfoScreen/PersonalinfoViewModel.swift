//
//  PersonalinfoViewModel.swift
//  HayatWalletTest
//
//  Created by Finartz on 1.08.2024.
//

import Foundation

class PersonalinfoViewModel{
    
    var fullName = ""
    var phoneNumber = ""
    var email = ""
    
    func fetchUserInfo(completion: @escaping (Result<Item,NetworkError>) -> Void ){
        guard let token = Transaction.shared.getToken() else{
            completion(.failure(.noData))
            return
        }
        let url = URL(string: "https://staging-api.cusp.link/user/viewuser")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("HTTP Request Failed \(error)")
                completion(.failure(.unknownError))
                return
            }
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode){
                completion(.failure(.httpError(statusCode: httpResponse.statusCode)))
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do{
                let loginInfo = try JSONDecoder().decode(LoginInfo.self, from: data)
                if let item = loginInfo.item {
                    Transaction.shared.saveFirstname(firstname: (loginInfo.item?.firstName)!)
                    
                    completion(.success(item))
                }else{
                    completion(.failure(.noData))
                }
            }catch{
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
}
