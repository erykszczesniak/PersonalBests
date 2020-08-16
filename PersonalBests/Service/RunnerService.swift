

import UIKit
import Alamofire
class RunnerService {

   var url = "http://127.0.0.1:8080/runners/"

    func getAllRunners(completion: @escaping (Result<[Runner], Error>) -> ()) {
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = HTTPMethod.get.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
                if let err = response.error {
                    completion(.failure(err))
                    return
                }
                
                do {
                    let runners = try JSONDecoder().decode([Runner].self, from: response.data!)
                    completion(.success(runners))
                    } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }.resume()
        }
        
        func createRunner(runner: Runner, completion: @escaping (Result<Int, Error>) -> ()) {
            let encoder = JSONEncoder()
            let data = try! encoder.encode(runner)
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
                if let err = response.error {
                    completion(.failure(err))
                    return
                }
                completion(.success(1))
            }.resume()
        }
        
        func updateRunner(id: Int, runner: Runner, completion: @escaping (Result<Int, Error>) -> ()) {
            let encoder = JSONEncoder()
            let data = try! encoder.encode(runner)
            var request = URLRequest(url: URL(string: url + String(id))!)
            request.httpMethod = HTTPMethod.put.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
                if let err = response.error {
                    completion(.failure(err))
                    return
                }
                completion(.success(1))
            }.resume()
        }
        
        func deleteRunner(id: Int, completion: @escaping (Result<Int, Error>) -> ()) {
            var request = URLRequest(url: URL(string: url + String(id))!)
            request.httpMethod = HTTPMethod.delete.rawValue
            AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
                if let err = response.error {
                    completion(.failure(err))
                    return
                }
                completion(.success(1))
            }.resume()
        }
    }
  
