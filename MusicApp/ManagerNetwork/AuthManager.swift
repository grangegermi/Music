//
//  AuthManager.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import Foundation
import SwiftKeychainWrapper

final class AuthManager {
    
    static let shared = AuthManager()
    
    struct Constants {
        
        static let clientID = "ce369415299e4fcd9a79f9086cc4f8e3"
        static let clientSecret = "9628ed2895874590bc12915ef9fd3f74"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectUrl = "https://soundcloud.com"
        static let scope = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    private init(){}
    
    public var isSignedURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scope)&redirect_uri=\(Constants.redirectUrl)&show_dialog=TRUE"
        
        return URL(string: string)
    }
    
    // Tocken
    func getTokens (code:String,completion: @escaping ((Bool) -> Void)) {
        
        guard let tokenUrl = URL(string: Constants.tokenAPIURL) else {
            return
        }
        var requestUrl = URLRequest(url: tokenUrl)
        requestUrl.httpMethod = "POST"
        requestUrl.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            URLQueryItem(name: "redirect_uri",
                         value: Constants.redirectUrl),
            URLQueryItem(name: "code", value:code)]
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("fail")
            completion(false)
            return
            
        }
        
        requestUrl.setValue("Basic \(base64String)",
                            forHTTPHeaderField: "Authorization")
        
        requestUrl.httpBody = components.query?.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: requestUrl) { data, error, response  in
            
            guard let data = data else {return}
            
            do {
                
                let result =  try JSONDecoder().decode(AuthResponse.self, from: data)
                self.casheToken(result:result)
                print(result)
                completion(true)
            } catch{
                completion(false)
                print(error)
            }
        }
        task.resume()
    }
    
    // RefreshToken
    func getRefreshToken(completion:@escaping ((Result<String,Error>)) -> Void) {
        
        guard let urlToken = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "refresh_token"),
            URLQueryItem(name: "refresh_token",
                         value: refreshToken)]
        
        var request = URLRequest(url: urlToken)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("fail")
            
            return
        }
        
        request.setValue("Basic \(base64String)",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, error, _ in
            guard let data = data else {return}
            
            
            do {
                
                var result = try JSONDecoder().decode(AuthResponse.self, from: data)
                var token = result.access_token
                completion(.success(token))
                
                
                
            }catch let error {
                completion(.failure(error))
                print(error)
            }
            
        }
        task.resume()
        
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    var accessToken: String? {
        
        return KeychainWrapper.standard.string(forKey: "access_token")
        
    }
    
    var refreshToken:String?{
        
        return KeychainWrapper.standard.string(forKey: "refresh_token")
        
    }
    
    var tokenDate:Date?{
        
        return KeychainWrapper.standard.object(forKey: "expires_in") as? Date
        
        
    }
    
    
    func casheToken(result:AuthResponse){
        
        KeychainWrapper.standard.set(result.access_token, forKey: "access_token")
        
        if  let token = result.refresh_token  {
            KeychainWrapper.standard.set(token, forKey: "refresh_token")
            
        }
        
        KeychainWrapper.standard.set(Double(Date().timeIntervalSinceNow) + Double(result.expires_in), forKey: "expires_in")
    }
    
}
