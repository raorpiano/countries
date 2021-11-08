//
//  WebService.swift
//  Countries
//
//  Created by Roy Orpiano on 11/08/21.
//

import Foundation




class Webservice: NSObject, URLSessionDelegate {
    
    static func fetchAllCountries(completion: @escaping (Result<Data, Error>) -> Void) {
        let endPoint = "https://restcountries.com/v2/all"
        
        let url: URL? = URL(string: endPoint)
        
        var request: URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3 * 60

        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else if error != nil {
                completion(.failure(error!))
            } else {
                let error = NSError(domain: "", code: 999, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.serverTrust == nil {
            completionHandler(.useCredential, nil)
        } else {
            let trust: SecTrust = challenge.protectionSpace.serverTrust!
            let credential = URLCredential(trust: trust)
            completionHandler(.useCredential, credential)
        }
    }
    
    
}

extension SecTrust {

    var isSelfSigned: Bool? {
        guard SecTrustGetCertificateCount(self) == 1 else {
            return false
        }
        guard let cert = SecTrustGetCertificateAtIndex(self, 0) else {
            return nil
        }
        return cert.isSelfSigned
    }
}

extension SecCertificate {

    var isSelfSigned: Bool? {
        guard
            let subject = SecCertificateCopyNormalizedSubjectSequence(self),
            let issuer = SecCertificateCopyNormalizedIssuerSequence(self)
        else {
            return nil
        }
        return subject == issuer
    }
}
