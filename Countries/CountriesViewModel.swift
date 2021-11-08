//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Roy Orpiano on 11/8/21.
//

import Foundation

class CountriesViewModel {
    
    func getAllCountries(completion: @escaping (Result<[Country], Error>)->Void) {
        Webservice.fetchAllCountries { result in
            switch result {
            case .success(let data):
                do {
                    let responseData = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(responseData))
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
